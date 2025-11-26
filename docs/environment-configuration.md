# Environment Configuration

The development environment can be configured using environment variables, configuration files, and marker files.

## .env File

Create a `.env` file in the root of your development directory to set environment variables:

```bash
cd ~/development
nano .env
```

### Common Environment Variables

```bash
# MySQL root password
MYSQL_ROOT_PASSWORD=secret

# Varnish cache size
CACHE_SIZE=256M

# Composer memory limit
COMPOSER_MEMORY_LIMIT=-1

# Domain suffix (default: .localhost)
DOMAIN_SUFFIX=.localhost
```

The `.env` file is gitignored by default, so your local settings won't be committed.

## Configuration Markers

Many services are enabled by creating marker directories in `conf/`:

```bash
mkdir -p conf/elasticsearch    # Enable Elasticsearch
mkdir -p conf/rabbitmq         # Enable RabbitMQ
mkdir -p conf/mongo            # Enable MongoDB
mkdir -p conf/opensearch       # Enable OpenSearch
mkdir -p conf/varnish          # Enable Varnish
mkdir -p conf/blackfire        # Enable Blackfire
```

After creating markers, rebuild:
```bash
dev rebuild
```

## Service-Specific Configuration

### MySQL

MySQL configuration is in `conf/mysql/my.cnf`:
```bash
mkdir -p conf/mysql
nano conf/mysql/my.cnf
```

Example configuration:
```ini
[mysqld]
max_connections = 200
innodb_buffer_pool_size = 1G
```

### Blackfire

Blackfire credentials in `conf/blackfire`:
```bash
BLACKFIRE_CLIENT_ID=your-client-id
BLACKFIRE_CLIENT_TOKEN=your-client-token
BLACKFIRE_SERVER_ID=your-server-id
BLACKFIRE_SERVER_TOKEN=your-server-token
```

See [configure-blackfire.md](configure-blackfire.md) for details.

### Varnish

Varnish VCL configuration in `conf/varnish.vcl`. See [varnish.md](varnish.md) for details.

## Setup Wizard

Run the setup wizard to configure your environment interactively:
```bash
dev setup
```

The wizard will:
- Set your domain suffix
- Choose default PHP version
- Enable optional services
- Configure workspace and database volumes

You can run `dev setup` multiple times to reconfigure.

## PHP Version Configuration

PHP versions are set using marker files in your workspace. See [how-to-use-different-php-versions.md](how-to-use-different-php-versions.md) for details.

## Docker Compose Overrides

For advanced configuration, use custom compose files. See [custom-compose-files.md](custom-compose-files.md).

## Troubleshooting

### Changes Not Taking Effect

After modifying configuration files, restart the affected service:
```bash
dev restart servicename
```

Or rebuild entirely:
```bash
dev rebuild
```

### Finding Configuration Files

List all configuration:
```bash
ls -la conf/
```

View current environment variables:
```bash
cat .env
```
