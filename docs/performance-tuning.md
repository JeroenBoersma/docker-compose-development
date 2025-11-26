# Performance Tuning

This guide covers performance optimization techniques for your Docker development environment.

## Composer Performance

### Memory Limit

Composer can consume significant memory. Increase the limit:

In `.env`:
```bash
COMPOSER_MEMORY_LIMIT=-1
```

This is the default in the environment (unlimited memory).

### Composer Version

Use Composer 2 for better performance:
```bash
dev composer2 install
```

Composer 2 is significantly faster than Composer 1.

### Platform Check

Disable platform requirements check for faster installs:
```bash
dev composer2 install --no-plugins --no-scripts
```

Or configure globally:
```bash
dev composer2 config platform-check false
```

### Parallel Downloads

Composer 2 automatically downloads packages in parallel. For Composer 1:
```bash
dev composer1 global require hirak/prestissimo
```

## PHP Performance

### OPcache

OPcache is enabled by default in PHP containers. Verify:
```bash
dev php -i | grep opcache
```

### Memory Limit

Increase PHP memory limit for resource-intensive scripts:
```bash
dev php -d memory_limit=512M script.php
```

Or set globally in `docker-custom.yml`:
```yaml
services:
  php82:
    environment:
      PHP_MEMORY_LIMIT: 512M
```

### Execution Time

For long-running scripts:
```bash
dev php -d max_execution_time=300 script.php
```

## MySQL Performance

### Configuration

Optimize MySQL in `conf/mysql/my.cnf`:
```ini
[mysqld]
# Memory
innodb_buffer_pool_size = 2G
key_buffer_size = 256M
max_allowed_packet = 64M

# Connections
max_connections = 200

# Query cache (MySQL 5.7 only)
query_cache_type = 1
query_cache_size = 64M

# InnoDB
innodb_flush_log_at_trx_commit = 2
innodb_log_file_size = 256M

# Temporary tables
tmp_table_size = 64M
max_heap_table_size = 64M
```

After changes:
```bash
dev restart db
```

### Slow Query Log

Enable slow query logging:
```ini
[mysqld]
slow_query_log = 1
slow_query_log_file = /var/log/mysql/slow.log
long_query_time = 2
```

View slow queries:
```bash
dev exec db tail -f /var/log/mysql/slow.log
```

### Index Optimization

Find tables without indexes:
```sql
SELECT DISTINCT
    tables.table_schema,
    tables.table_name
FROM information_schema.tables
LEFT JOIN information_schema.statistics
    ON tables.table_schema = statistics.table_schema
    AND tables.table_name = statistics.table_name
WHERE statistics.index_name IS NULL
    AND tables.table_schema NOT IN ('mysql', 'information_schema', 'performance_schema')
    AND tables.table_type = 'BASE TABLE';
```

## Docker Performance

### Volume Performance

**Linux:** Native performance, no optimization needed.

**macOS/Windows:** Use Docker volumes instead of bind mounts:
```bash
dev volume workspace workspace
```

This significantly improves I/O performance.

### Resource Allocation

Allocate more resources to Docker:

**Docker Desktop Settings:**
- CPUs: 4+ cores recommended
- Memory: 8+ GB recommended
- Swap: 2+ GB
- Disk image size: 100+ GB

### BuildKit

Enable Docker BuildKit for faster builds:
```bash
export DOCKER_BUILDKIT=1
```

Add to `~/.bashrc` or `~/.zshrc` for persistence.

### Layer Caching

Optimize Dockerfile layer caching by ordering commands from least to most frequently changed:

```dockerfile
# Rarely changes - good for caching
FROM php:8.2-fpm

# System packages - changes occasionally
RUN apt-get update && apt-get install -y \
    package1 package2

# PHP extensions - changes occasionally
RUN docker-php-ext-install pdo_mysql

# Application dependencies - changes more frequently
COPY composer.json composer.lock ./
RUN composer install --no-dev

# Application code - changes most frequently
COPY . .
```

## Elasticsearch/OpenSearch Performance

### Memory Settings

Set JVM heap size (should be 50% of available RAM, max 32GB):
```yaml
services:
  elasticsearch:
    environment:
      - "ES_JAVA_OPTS=-Xms1g -Xmx1g"
```

### Disable Swapping

In `docker-custom.yml`:
```yaml
services:
  elasticsearch:
    environment:
      - bootstrap.memory_lock=true
    ulimits:
      memlock:
        soft: -1
        hard: -1
```

## Varnish Performance

### Cache Size

Increase Varnish cache size in `.env`:
```bash
CACHE_SIZE=1G
```

### Monitoring

Check Varnish hit rate:
```bash
dev exec varnish varnishadm stats
```

Look for `cache_hit` vs `cache_miss` ratio.

## Redis Performance

### Persistent Storage

For development, disable persistence for better performance:
```yaml
services:
  redis:
    command: redis-server --appendonly no --save ""
```

### Memory Limit

Set max memory:
```yaml
services:
  redis:
    command: redis-server --maxmemory 256mb --maxmemory-policy allkeys-lru
```

## Application-Specific

### Magento 2

**Production Mode:**
```bash
dev console bin/magento deploy:mode:set production
dev console bin/magento cache:flush
```

**Flat Catalog:**
Enable flat tables for categories and products:
- **Stores** > **Configuration** > **Catalog** > **Catalog**
- Enable "Use Flat Catalog Category"
- Enable "Use Flat Catalog Product"

**Indexers:**
Switch to "Update on Schedule":
```bash
dev console bin/magento indexer:set-mode schedule catalog_category_product
dev console bin/magento indexer:set-mode schedule catalog_product_category
# ... etc for all indexers
```

**Static Content:**
Deploy static content:
```bash
dev console bin/magento setup:static-content:deploy -f
```

### Laravel

**Config Caching:**
```bash
dev console php artisan config:cache
dev console php artisan route:cache
dev console php artisan view:cache
```

**OPcache:**
Already enabled in PHP containers.

## Monitoring Performance

### Container Resources

Monitor resource usage:
```bash
dev top
```

### Identify Bottlenecks

Check which container is consuming resources:
```bash
docker stats
```

### Application Profiling

Use Blackfire for application profiling:
```bash
dev blackfire curl http://your-site.localhost
```

See [configure-blackfire.md](configure-blackfire.md).

## Common Issues

### Slow File Operations

**Problem:** File operations (composer, npm) are slow.
**Solution:** Use Docker volumes instead of bind mounts (macOS/Windows).

### High CPU Usage

**Problem:** Constant high CPU.
**Solution:** Check logs for errors causing retry loops:
```bash
dev logs
```

### Out of Memory

**Problem:** Containers crashing or OOM errors.
**Solution:**
- Increase Docker Desktop memory allocation
- Reduce container memory limits
- Optimize application memory usage

### Database Queries Slow

**Problem:** Slow database queries.
**Solution:**
- Enable slow query log
- Add indexes
- Optimize queries
- Increase `innodb_buffer_pool_size`

## Benchmarking

### Database Performance

```bash
dev myroot -e "SHOW ENGINE INNODB STATUS\G"
```

### Web Performance

Use Apache Bench:
```bash
dev exec php ab -n 1000 -c 10 http://your-site.localhost/
```

### PHP Performance

Compare script execution time:
```bash
time dev php script.php
```

## See Also

- [monitoring-tools.md](monitoring-tools.md) - Performance monitoring
- [advanced-docker-configuration.md](advanced-docker-configuration.md) - Resource limits
- [configure-blackfire.md](configure-blackfire.md) - Application profiling
