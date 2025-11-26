# Docker Volumes

Docker volumes provide persistent storage for your workspace, databases, and other data. This guide covers volume management in the development environment.

## Volume Command

Manage volumes with the `dev volume` command:
```bash
dev volume [VOLUME_NAME] [HOST_PATH]
```

## Workspace Volume

By default, the workspace is stored in a Docker volume. To use a local directory instead:

```bash
cd ~/development
dev down --remove-orphans
dev volume rm workspace
mkdir workspace
dev volume workspace workspace
dev up
```

Now `~/development/workspace` contains your projects and is directly accessible.

## MySQL Volume

Make MySQL data persistent in your development directory:

```bash
cd ~/development
dev down --remove-orphans
dev volume rm mysql
mkdir mysql
dev volume mysql mysql
dev setup
```

Warning: This destroys existing databases. Export data first if needed.

## MySQL 8 Volume

For MySQL 8 persistence:
```bash
cd ~/development
dev down --remove-orphans
dev volume rm mysql8
mkdir mysql8
dev volume mysql8 mysql8
dev setup
```

## Benefits of Local Volumes

Using local directories instead of Docker volumes:
- **Easier backups**: Standard file system backups work
- **Direct access**: Edit files with any tool
- **Version control**: Can add to git if desired (workspace not recommended)
- **Visibility**: See exactly what's stored

## Benefits of Docker Volumes

Using Docker volumes:
- **Performance**: Better I/O performance, especially on macOS
- **Automatic management**: Docker handles cleanup
- **Isolation**: No conflicts with host filesystem

## Listing Volumes

List all volumes:
```bash
docker volume ls | grep dockerdev
```

## Volume Inspection

Inspect a volume:
```bash
docker volume inspect dockerdev-workspace-volume
```

## Removing Volumes

Remove a specific volume:
```bash
dev down
dev volume rm volumename
```

Warning: This permanently deletes data. Backup first.

Remove all unused volumes:
```bash
docker volume prune
```

## Volume Permissions

Volumes inherit the UID/GID from the container processes, which match your user. If you encounter permission issues:

Check current permissions:
```bash
ls -la workspace/
```

Fix permissions:
```bash
sudo chown -R $USER:$USER workspace/
```

## Backup Strategies

### Workspace Backup

If using local workspace:
```bash
tar -czf workspace-backup.tar.gz workspace/
```

If using Docker volume:
```bash
docker run --rm -v dockerdev-workspace-volume:/data -v $(pwd):/backup ubuntu tar czf /backup/workspace-backup.tar.gz /data
```

### Database Backup

Export databases:
```bash
dev mysqldump database > database-backup.sql
```

Or backup the entire MySQL directory if using local volumes:
```bash
tar -czf mysql-backup.tar.gz mysql/
```

## Restore from Backup

### Workspace Restore

```bash
tar -xzf workspace-backup.tar.gz
```

### Database Restore

```bash
dev mysql database < database-backup.sql
```

## Troubleshooting

### Volume Not Found

If a volume is missing, recreate it:
```bash
dev volume workspace workspace
```

### Disk Space Issues

Check volume sizes:
```bash
docker system df -v
```

Clean up unused volumes:
```bash
docker volume prune
```
