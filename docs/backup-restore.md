# Backup and Restore

This guide covers backup and restore strategies for databases, files, and volumes in your development environment.

## Database Backups

### Single Database

Export a specific database:
```bash
dev mysqldump database_name > backup.sql
```

With compression:
```bash
dev mysqldump database_name | gzip > backup.sql.gz
```

### All Databases

Backup all databases:
```bash
dev mysqldump --all-databases > all_databases.sql
```

### Specific Tables

Backup specific tables:
```bash
dev mysqldump database_name table1 table2 > tables_backup.sql
```

### Schema Only

Backup structure without data:
```bash
dev mysqldump --no-data database_name > schema.sql
```

### Data Only

Backup data without structure:
```bash
dev mysqldump --no-create-info database_name > data.sql
```

## Database Restore

### Restore Single Database

```bash
dev mysql database_name < backup.sql
```

From compressed backup:
```bash
gunzip < backup.sql.gz | dev mysql database_name
```

### Create Database First

If the database doesn't exist:
```bash
dev mysql -e "CREATE DATABASE database_name;"
dev mysql database_name < backup.sql
```

### Restore All Databases

```bash
dev myroot < all_databases.sql
```

Note: Use `myroot` for restoring all databases as it requires root privileges.

## MySQL 8 Backups

For MySQL 8 databases, use direct connection:

### Backup
```bash
mysqldump -h 127.0.0.1 -P 3308 -u root -p database_name > backup.sql
```

### Restore
```bash
mysql -h 127.0.0.1 -P 3308 -u root -p database_name < backup.sql
```

## Workspace Backups

### Entire Workspace

If using local workspace directory:
```bash
cd ~/development
tar -czf workspace-backup-$(date +%Y%m%d).tar.gz workspace/
```

### Specific Project

Backup a single project:
```bash
cd ~/development/workspace
tar -czf project-backup-$(date +%Y%m%d).tar.gz customer/project/
```

### Exclude Dependencies

Exclude vendor and node_modules:
```bash
tar -czf project-backup.tar.gz \
  --exclude='vendor' \
  --exclude='node_modules' \
  --exclude='.git' \
  customer/project/
```

## Docker Volume Backups

### Workspace Volume

If using Docker volumes instead of local directories:
```bash
docker run --rm \
  -v dockerdev-workspace-volume:/data \
  -v $(pwd):/backup \
  ubuntu tar czf /backup/workspace-backup-$(date +%Y%m%d).tar.gz /data
```

### MySQL Volume

Backup MySQL data directory:
```bash
docker run --rm \
  -v dockerdev-mysql-volume:/data \
  -v $(pwd):/backup \
  ubuntu tar czf /backup/mysql-backup-$(date +%Y%m%d).tar.gz /data
```

## Restore from Backups

### Workspace Restore

```bash
cd ~/development
tar -xzf workspace-backup-20241126.tar.gz
```

### Volume Restore

```bash
docker run --rm \
  -v dockerdev-workspace-volume:/data \
  -v $(pwd):/backup \
  ubuntu bash -c "cd /data && tar xzf /backup/workspace-backup.tar.gz --strip 1"
```

## Automated Backups

### Daily Database Backup Script

Create `~/bin/dev-backup.sh`:
```bash
#!/bin/bash
BACKUP_DIR=~/backups
DATE=$(date +%Y%m%d)

mkdir -p $BACKUP_DIR

cd ~/development

# Backup all databases
./bin/dev mysqldump --all-databases | gzip > $BACKUP_DIR/databases-$DATE.sql.gz

# Backup workspace
tar -czf $BACKUP_DIR/workspace-$DATE.tar.gz \
  --exclude='workspace/*/vendor' \
  --exclude='workspace/*/node_modules' \
  workspace/

# Keep only last 7 days
find $BACKUP_DIR -name "*.sql.gz" -mtime +7 -delete
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -delete
```

Make it executable:
```bash
chmod +x ~/bin/dev-backup.sh
```

### Cron Job

Add to crontab (`crontab -e`):
```bash
# Daily backup at 2 AM
0 2 * * * ~/bin/dev-backup.sh
```

## Magento-Specific Backups

### Magento 2 Full Backup

```bash
cd workspace/customer/project/htdocs

# Database
dev mysqldump magento2 | gzip > ../backups/db-$(date +%Y%m%d).sql.gz

# Media files
tar -czf ../backups/media-$(date +%Y%m%d).tar.gz pub/media/

# Configuration
cp app/etc/env.php ../backups/env.php.backup
```

### Magento 2 Restore

```bash
cd workspace/customer/project/htdocs

# Database
gunzip < ../backups/db-20241126.sql.gz | dev mysql magento2

# Media
tar -xzf ../backups/media-20241126.tar.gz

# Configuration
cp ../backups/env.php.backup app/etc/env.php

# Clear cache
dev console bin/magento cache:flush
```

## Best Practices

### Before Updates

Always backup before:
- Upgrading PHP versions
- Updating major dependencies
- Significant code changes
- Docker environment updates

### What to Backup

**Essential:**
- Databases
- Custom code
- Configuration files
- User-uploaded content

**Optional:**
- Vendor dependencies (can be reinstalled)
- Generated files (can be regenerated)
- Cache (not needed)

### Storage

Store backups:
- On a different disk/partition
- In cloud storage (S3, Dropbox, etc.)
- On external drives
- Multiple locations for critical data

### Testing Restores

Periodically test your backups:
```bash
# Test database restore
dev mysql test_db < backup.sql
dev mysql -e "SHOW TABLES FROM test_db;"
dev mysql -e "DROP DATABASE test_db;"
```

## Quick Backup Commands

### Before Risky Operation

```bash
# Quick database backup
dev mysqldump mydb > quick-backup-$(date +%H%M).sql

# Quick file snapshot
tar -czf quick-backup-$(date +%H%M).tar.gz workspace/customer/project/
```

### After Successful Changes

Delete quick backups:
```bash
rm quick-backup-*.sql
rm quick-backup-*.tar.gz
```

## Troubleshooting

### mysqldump: Command not found

Use the full dev command:
```bash
./bin/dev mysqldump database > backup.sql
```

### Permission Denied

Ensure you have write permissions:
```bash
ls -la
chmod +w .
```

### Out of Disk Space

Check available space:
```bash
df -h
```

Clean up old backups or compress existing ones.

### Corrupt Backup

Verify backup integrity:
```bash
gunzip -t backup.sql.gz
tar -tzf backup.tar.gz
```

## See Also

- [mysql-mailhog-redis-cronjobs.md](mysql-mailhog-redis-cronjobs.md) - Database basics
- [mysql8.md](mysql8.md) - MySQL 8 specifics
- [docker-volumes.md](docker-volumes.md) - Volume management
