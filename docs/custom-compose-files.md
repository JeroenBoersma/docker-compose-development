# Custom Docker Compose Files

You can customize and extend the Docker Compose configuration without modifying the core files. This allows you to receive updates while maintaining your custom configuration.

## docker-custom.yml

The `docker-custom.yml` file is gitignored and allows you to override or extend any service configuration.

### Creating docker-custom.yml

Create the file in your development root:
```bash
cd ~/development
nano docker-custom.yml
```

### Basic Structure

```yaml
version: '2'

services:
  servicename:
    # Your customizations here
```

### Example: Custom PHP Container

To add custom components to the PHP container:

**1. Create docker-custom.yml:**
```yaml
version: '2'

services:
  php:
    build: custom/php
```

**2. Create custom Dockerfile:**
```bash
mkdir -p custom/php
nano custom/php/Dockerfile
```

**3. Extend the base PHP image:**
```dockerfile
FROM ghcr.io/jeroenboersma/php-development:8.2-fpm

# Install additional packages
RUN apt-get update && apt-get install -y \
    your-package-here \
    && rm -rf /var/lib/apt/lists/*

# Install additional PHP extensions
RUN docker-php-ext-install extensionname

# Copy custom configuration
COPY custom-config.ini /usr/local/etc/php/conf.d/
```

**4. Rebuild:**
```bash
dev rebuild
```

### Example: Override Environment Variables

```yaml
version: '2'

services:
  db:
    environment:
      MYSQL_ROOT_PASSWORD: mycustompassword

  php82:
    environment:
      PHP_MEMORY_LIMIT: 512M
```

### Example: Add Custom Volumes

```yaml
version: '2'

services:
  php:
    volumes:
      - /path/on/host:/path/in/container
```

### Example: Expose Additional Ports

```yaml
version: '2'

services:
  web:
    ports:
      - "8080:80"
```

## docker-compose-dev.yml

For project-specific overrides, use `docker-compose-dev.yml`. This can be committed to your project repository.

Place it in your project directory:
```bash
cd workspace/customer/project
nano docker-compose-dev.yml
```

## Custom Build Directory

The `./custom` directory is gitignored and meant for your customizations:

```
custom/
├── php/
│   ├── Dockerfile
│   └── config.ini
├── nginx/
│   └── custom-site.conf
└── mysql/
    └── custom.cnf
```

## Combining Multiple Compose Files

Docker Compose automatically merges configurations in this order:
1. `docker-compose.yml` (base)
2. `build/dist/docker-compose-*.yml` (enabled services)
3. `docker-custom.yml` (your customizations)
4. `docker-compose-dev.yml` (project-specific)

Later files override earlier ones.

## Best Practices

### Do:
- Use `docker-custom.yml` for personal/environment-specific changes
- Use `docker-compose-dev.yml` for project-specific changes
- Document your customizations
- Keep custom Dockerfiles simple

### Don't:
- Modify core `docker-compose.yml` directly (you'll lose changes on update)
- Commit `docker-custom.yml` to version control
- Override critical service dependencies
- Make breaking changes to service names/networks

## Advanced Customizations

### Adding a New Service

```yaml
version: '2'

services:
  myservice:
    image: myimage:latest
    networks:
      - default
    volumes:
      - dockerdev-workspace-volume:/data
```

### Changing PHP Version Default

```yaml
version: '2'

services:
  php:
    build:
      context: build/dist/php
      args:
        PHP_VERSION: 8.3
```

### Custom Network Configuration

```yaml
version: '2'

services:
  myservice:
    networks:
      mynetwork:
        ipv4_address: 172.25.0.100

networks:
  mynetwork:
    driver: bridge
    ipam:
      config:
        - subnet: 172.25.0.0/16
```

## Troubleshooting

### Rebuild After Changes

Always rebuild after modifying compose files:
```bash
dev rebuild
```

### Verify Configuration

Check the merged configuration:
```bash
dev config
```

This shows the final composed configuration.

### Syntax Errors

Validate your YAML:
```bash
docker-compose -f docker-custom.yml config
```

### Changes Not Applied

Ensure you're using the correct file name:
- `docker-custom.yml` (not `docker-custom.yaml`)
- Place it in the development root directory

Force recreation:
```bash
dev down
dev up --force-recreate
```

## See Also

- [customize-docker-containers.md](customize-docker-containers.md) - Basic customization guide
- [environment-configuration.md](environment-configuration.md) - Environment variables
