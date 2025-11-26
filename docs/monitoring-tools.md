# Monitoring Tools

Several monitoring tools are available to help you track resource usage, monitor processes, and inspect your development environment.

## Container Resource Monitoring

### dev top

Monitor all running containers and their resource usage:
```bash
dev top
```

This shows:
- CPU usage per container
- Memory consumption
- Network I/O
- Block I/O
- Process counts

Press `Ctrl+C` to exit.

### ctop

ctop is an enhanced container monitoring tool with a more detailed interface. Enable it during setup:
```bash
mkdir -p conf/ctop
dev rebuild
```

Then run:
```bash
dev exec ctop ctop
```

ctop provides:
- Real-time container metrics
- Interactive container management
- Resource usage graphs
- Container logs access

## MySQL Monitoring

### mytop

mytop monitors MySQL queries and processes in real-time. It's similar to `top` but for MySQL.

Enable mytop:
```bash
mkdir -p conf/mytop
dev rebuild
```

Run mytop:
```bash
dev mytop
```

mytop shows:
- Currently running queries
- Query execution time
- Database connections
- Slow queries
- Server status

Press `q` to quit.

### MySQL Process List

View current MySQL processes:
```bash
dev mysql -e "SHOW PROCESSLIST;"
```

For full query text:
```bash
dev mysql -e "SHOW FULL PROCESSLIST;"
```

## Docker System Monitoring

### System Info

View Docker system information:
```bash
docker system info
```

### Disk Usage

Check Docker disk usage:
```bash
docker system df
```

For detailed breakdown:
```bash
docker system df -v
```

### Container Stats

Real-time stats for all containers:
```bash
docker stats
```

Stats for specific container:
```bash
docker stats php
```

## Service-Specific Monitoring

### RabbitMQ Management Interface

Monitor RabbitMQ queues and messages at: [http://localhost:15672](http://localhost:15672)

See [rabbitmq.md](rabbitmq.md) for details.

### Elasticsearch/OpenSearch

Check cluster health:
```bash
dev console curl -X GET "elasticsearch:9200/_cluster/health?pretty"
```

Or for OpenSearch:
```bash
dev console curl -X GET "opensearch:9200/_cluster/health?pretty"
```

### Elasticsearch HQ

Web-based Elasticsearch monitoring. Enable it:
```bash
mkdir -p conf/elasticsearchhq
dev rebuild
```

Access at: [http://localhost:5000](http://localhost:5000)

See [search-ui-tools.md](search-ui-tools.md) for more details.

### ElasticVue

Modern Elasticsearch/OpenSearch web UI. Enable it:
```bash
mkdir -p conf/elasticvue
dev rebuild
```

Access at: [http://localhost:8080](http://localhost:8080)

See [search-ui-tools.md](search-ui-tools.md) for more details.

## Log Monitoring

### Container Logs

View logs for any container:
```bash
dev logs containername
```

Follow logs in real-time:
```bash
dev logs -f containername
```

View last 100 lines:
```bash
dev logs --tail=100 containername
```

### Multiple Container Logs

View logs from multiple containers:
```bash
dev logs php nginx
```

## Performance Profiling

For application performance profiling:
- **XDebug**: See [xdebug.md](xdebug.md)
- **Blackfire**: See [configure-blackfire.md](configure-blackfire.md)

## Troubleshooting Performance Issues

### High CPU Usage

Identify which container is using CPU:
```bash
dev top
```

Check processes inside that container:
```bash
dev exec containername top
```

### High Memory Usage

Check memory usage:
```bash
docker stats --no-stream
```

Inspect specific container:
```bash
docker inspect containername | grep -i memory
```

### Slow Database Queries

Use mytop to identify slow queries:
```bash
dev mytop
```

Or check the slow query log (if enabled in MySQL configuration).

### Network Issues

Monitor network I/O:
```bash
dev top
```

Check container networking:
```bash
docker network inspect dockerdev_default
```
