# MySQL 8

MySQL 8 is available as an optional secondary database server running alongside the default MySQL 5.7/Percona instance. This allows you to test applications against MySQL 8 or run multiple database versions simultaneously.

## Setup

Enable MySQL 8 during the initial setup:
```bash
dev setup
```

If you've already set up your environment:
```bash
mkdir -p conf/mysql8
dev rebuild
```

## Configuration

MySQL 8 runs on a different port to avoid conflicts with the default database:

- **Host**: `localhost` (from your machine) or `db8` (from containers)
- **Port**: `3308` (note: different from default 3306)
- **Root password**: Same as your main MySQL instance (set in conf/mysql)

## Connecting to MySQL 8

### From Your Host Machine

```bash
mysql -h 127.0.0.1 -P 3308 -u root -p
```

### From PHP Containers

Use the hostname `db8` and standard port `3306`:
```php
$connection = new PDO('mysql:host=db8;port=3306;dbname=mydb', 'root', 'password');
```

### Using Dev Commands

The standard `dev mysql` command connects to the default database. For MySQL 8, use the direct connection method above.

## MySQL 8 vs MySQL 5.7

Key differences in MySQL 8:
- **Authentication**: Default authentication plugin changed to `caching_sha2_password`
- **Performance**: Improved query optimizer and performance
- **JSON**: Enhanced JSON functionality
- **Window Functions**: Support for window functions
- **CTEs**: Common Table Expressions (WITH clause)
- **Roles**: Better role-based access control

## Application Configuration

### Magento 2

Magento 2.4.4+ officially supports MySQL 8. In `env.php`:
```php
'db' => [
    'connection' => [
        'default' => [
            'host' => 'db8',
            'dbname' => 'magento',
            'username' => 'root',
            'password' => 'yourpassword',
            'port' => '3306'
        ]
    ]
]
```

### Laravel

In `.env`:
```
DB_CONNECTION=mysql
DB_HOST=db8
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=root
DB_PASSWORD=yourpassword
```

## Running Both MySQL Versions

You can run both MySQL 5.7 and MySQL 8 simultaneously:
- **MySQL 5.7/Percona**: `db` on port 3306
- **MySQL 8**: `db8` on port 3308

This allows you to:
- Test compatibility before upgrading
- Run different projects on different MySQL versions
- Migrate data between versions

## Data Persistence

MySQL 8 uses a separate Docker volume for data persistence. To make it persistent in your development directory:

```bash
cd ~/development
dev down --remove-orphans
dev volume rm mysql8
mkdir mysql8
dev volume mysql8 mysql8
dev setup
```

## Troubleshooting

Check if MySQL 8 is running:
```bash
dev ps | grep db8
```

View MySQL 8 logs:
```bash
dev logs db8
```

Test connectivity:
```bash
mysql -h 127.0.0.1 -P 3308 -u root -p -e "SELECT VERSION();"
```

### Authentication Plugin Issues

If you get "Authentication plugin 'caching_sha2_password' cannot be loaded", your MySQL client may be outdated. Either:
1. Update your MySQL client
2. Create users with the older authentication method in MySQL 8
