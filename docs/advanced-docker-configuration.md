# Advanced Docker Configuration

This guide covers advanced Docker configuration topics including user ID mapping, build arguments, network modes, and performance optimization.

## UID/GID Mapping

The environment automatically maps your user ID and group ID into containers to avoid permission issues.

### How It Works

When building containers, your UID and GID are passed as build arguments:
```bash
docker-compose build --build-arg UID=$(id -u) --build-arg GID=$(id -g)
```

This ensures:
- Files created in containers have your ownership
- You can edit files created by containers
- No `sudo` needed for file operations

### Verifying UID/GID

Check your IDs:
```bash
id -u  # Your UID
id -g  # Your GID
```

Check container user:
```bash
dev console
id
```

Should match your host user.

### Custom UID/GID

To override the automatic detection, set in `.env`:
```bash
UID=1000
GID=1000
```

## Docker Build Arguments

Build arguments customize container builds without modifying Dockerfiles.

### Common Build Arguments

The environment supports:
- `UID` - User ID
- `GID` - Group ID
- `PHP_VERSION` - PHP version for builds
- `COMPOSER_MEMORY_LIMIT` - Composer memory limit

### Setting Build Arguments

In `docker-custom.yml`:
```yaml
version: '2'

services:
  php:
    build:
      context: custom/php
      args:
        PHP_VERSION: 8.3
        CUSTOM_ARG: value
```

### Using Build Arguments in Dockerfile

In your custom Dockerfile:
```dockerfile
ARG PHP_VERSION=8.2
FROM php:${PHP_VERSION}-fpm

ARG CUSTOM_ARG
RUN echo "Custom arg: ${CUSTOM_ARG}"
```

## Network Modes

### Default Bridge Network

Most services use the default bridge network, allowing container-to-container communication.

Services can reference each other by name:
```php
// From PHP container
$redis = new Redis();
$redis->connect('redis', 6379);

$db = new PDO('mysql:host=db;dbname=mydb', 'user', 'pass');
```

### Host Network Mode

Some services use host network mode for direct access to host networking:
- **ngrok** - For tunneling
- **expose** - For sharing

In `docker-custom.yml`:
```yaml
services:
  myservice:
    network_mode: host
```

### Custom Networks

Create isolated networks for specific services:

```yaml
version: '2'

services:
  myapp:
    networks:
      - frontend
      - backend

  mydb:
    networks:
      - backend

networks:
  frontend:
  backend:
    internal: true  # No external access
```

## Volume Performance

### Linux

On Linux, volumes have native performance. Use bind mounts freely:
```yaml
volumes:
  - ./workspace:/data/workspace
```

### macOS Performance

On macOS, use Docker volumes instead of bind mounts for better performance:
```bash
dev volume workspace workspace
```

Or use delegated/cached modes:
```yaml
volumes:
  - ./workspace:/data/workspace:delegated
```

### Windows

Similar to macOS, Docker volumes offer better performance than bind mounts.

## Resource Limits

Limit container resources to prevent one service from consuming all resources.

### Memory Limits

In `docker-custom.yml`:
```yaml
services:
  db:
    mem_limit: 2g
    memswap_limit: 2g

  elasticsearch:
    mem_limit: 1g
    environment:
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
```

### CPU Limits

```yaml
services:
  php:
    cpus: '2.0'  # Use up to 2 CPU cores
    cpu_shares: 1024  # Relative weight
```

## Container Restart Policies

Control what happens when containers exit:

```yaml
services:
  critical-service:
    restart: always

  optional-service:
    restart: unless-stopped

  dev-tool:
    restart: "no"
```

## Docker Compose Version

The environment uses Compose file version 2 for compatibility:
```yaml
version: '2'
```

Version 2 provides:
- Wide compatibility
- Named volumes
- Network support
- Stable feature set

## BuildKit

Enable Docker BuildKit for faster, more efficient builds:

```bash
export DOCKER_BUILDKIT=1
dev rebuild
```

Or permanently in `~/.bashrc` or `~/.zshrc`:
```bash
export DOCKER_BUILDKIT=1
```

Benefits:
- Parallel build stages
- Better layer caching
- Reduced build time
- Lower disk usage

## Health Checks

Add health checks to services:

```yaml
services:
  db:
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      timeout: 5s
      retries: 3
      start_period: 30s
```

Check health status:
```bash
dev ps
```

## Logging Configuration

Control container log output:

```yaml
services:
  php:
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```

This prevents logs from consuming excessive disk space.

## Security Considerations

### Read-Only Filesystems

Make containers more secure with read-only filesystems:
```yaml
services:
  web:
    read_only: true
    tmpfs:
      - /tmp
      - /var/run
```

### Drop Capabilities

Remove unnecessary Linux capabilities:
```yaml
services:
  app:
    cap_drop:
      - ALL
    cap_add:
      - NET_BIND_SERVICE
```

### User Namespace Remapping

For additional security, enable Docker user namespace remapping. See Docker documentation.

## Troubleshooting

### Permission Errors

Rebuild with correct UID/GID:
```bash
dev rebuild
```

Or fix permissions on host:
```bash
sudo chown -R $USER:$USER workspace/
```

### Network Issues

Inspect networks:
```bash
docker network ls
docker network inspect dockerdev_default
```

### Build Cache Issues

Clear build cache:
```bash
docker builder prune
dev rebuild --no-cache
```

### Resource Exhaustion

Check resource usage:
```bash
dev top
docker system df
```

Clean up:
```bash
docker system prune -a
docker volume prune
```

## See Also

- [custom-compose-files.md](custom-compose-files.md) - Custom configurations
- [docker-volumes.md](docker-volumes.md) - Volume management
- [performance-tuning.md](performance-tuning.md) - Optimization techniques
