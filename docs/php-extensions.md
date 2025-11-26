# PHP Extensions

PHP extensions can be enabled or disabled on-demand in your development environment. This guide covers managing PHP extensions.

## Available Commands

### Enable Extension

Temporarily enable a PHP extension for a running container:
```bash
dev php-ext-enable extensionname
```

### Disable Extension

Temporarily disable a PHP extension:
```bash
dev php-ext-disable extensionname
```

### Verify Extension

Check if an extension is loaded:
```bash
dev exec php php -m | grep extensionname
```

Or check PHP info:
```bash
dev php -i | grep extensionname
```

## Common Extensions

Most common PHP extensions are pre-installed:
- **mbstring** - Multibyte string functions
- **pdo_mysql** - MySQL database support
- **gd** - Image manipulation
- **curl** - HTTP requests
- **xml** - XML parsing
- **zip** - ZIP archive handling
- **intl** - Internationalization
- **soap** - SOAP client/server
- **bcmath** - Arbitrary precision math
- **redis** - Redis support
- **xdebug** - Debugging (see [xdebug.md](xdebug.md))
- **blackfire** - Profiling (see [configure-blackfire.md](configure-blackfire.md))

## List All Extensions

See all loaded extensions:
```bash
dev php -m
```

See PHP configuration:
```bash
dev php -i
```

## Temporary vs Permanent Changes

### Temporary (Until Container Restart)

The `php-ext-enable` and `php-ext-disable` commands make temporary changes:
```bash
dev php-ext-enable xdebug
dev exec php php -v  # XDebug is loaded
dev restart php
dev exec php php -v  # XDebug is gone
```

This is useful for:
- Testing extensions
- Temporarily enabling debugging
- Performance testing with/without extensions

### Permanent Configuration

For permanent changes, customize the PHP container. See [customize-docker-containers.md](customize-docker-containers.md).

Create `custom/php/Dockerfile`:
```dockerfile
FROM php:8.2-fpm

RUN docker-php-ext-install extensionname
```

Then use a `docker-custom.yml` to build from your custom Dockerfile.

## XDebug Special Case

XDebug is available but not enabled by default for performance. Use the dedicated command:
```bash
dev xdebug-console
```

See [xdebug.md](xdebug.md) for complete XDebug setup.

## Blackfire Special Case

Blackfire requires configuration before use. See [configure-blackfire.md](configure-blackfire.md).

## Installing Additional Extensions

If an extension isn't available, you have two options:

### Option 1: Custom Container

Create a custom PHP container with the extension. See [customize-docker-containers.md](customize-docker-containers.md).

### Option 2: Runtime Installation

Install temporarily in a running container:
```bash
dev exec php docker-php-ext-install extensionname
```

Note: This persists only until container rebuild.

## Extension Configuration

Some extensions require configuration files. These go in the PHP configuration directory inside the container.

Example for custom extension config:
```bash
dev exec php bash -c 'echo "extension=myext.so" > /usr/local/etc/php/conf.d/myext.ini'
```

## Troubleshooting

### Extension Not Found

List available extensions in the container:
```bash
dev exec php ls /usr/local/lib/php/extensions/
```

### Extension Won't Load

Check PHP error log:
```bash
dev logs php
```

Verify extension file exists:
```bash
dev exec php php --ri extensionname
```

### Version-Specific Extensions

Different PHP versions may have different extensions available. Switch PHP versions and check:
```bash
dev php-change php83
dev php -m
```
