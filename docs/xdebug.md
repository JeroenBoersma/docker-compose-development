# XDebug

XDebug is a debugging and profiling extension for PHP. This guide covers how to use XDebug in your development environment.

## XDebug Console

The quickest way to run PHP with XDebug enabled is using the `xdebug-console` command:

```bash
dev xdebug-console
```

This starts a PHP console with XDebug pre-configured and ready to connect to your IDE.

## IDE Configuration

### PhpStorm

1. Go to **Settings** > **PHP** > **Debug**
2. Set XDebug port to `9003` (XDebug 3.x) or `9000` (XDebug 2.x)
3. Enable "Can accept external connections"
4. Go to **Settings** > **PHP** > **Servers**
5. Add a server:
   - **Name**: `docker`
   - **Host**: Your project hostname (e.g., `project.localhost`)
   - **Port**: `80`
   - **Debugger**: `Xdebug`
   - Enable "Use path mappings"
   - Map your local project directory to `/data/workspace/customer/project`

### VS Code

Install the "PHP Debug" extension and add to `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Listen for XDebug",
      "type": "php",
      "request": "launch",
      "port": 9003,
      "pathMappings": {
        "/data/workspace/customer/project": "${workspaceFolder}"
      }
    }
  ]
}
```

## Running Scripts with XDebug

Execute any PHP script with XDebug:
```bash
dev xdebug-console php myscript.php
```

For Magento:
```bash
dev xdebug-console bin/magento cache:flush
```

For Composer:
```bash
dev xdebug-console composer install
```

## Web Request Debugging

XDebug is available in the PHP containers but not enabled by default for performance reasons. To debug web requests:

1. Set the XDebug trigger in your browser:
   - Install a browser extension (XDebug helper for Chrome/Firefox)
   - Or add `?XDEBUG_SESSION_START=PHPSTORM` to your URL

2. Start listening for connections in your IDE

3. Access your application in the browser

4. Your IDE should break on the first line or your breakpoints

## Profiling

XDebug can also profile your application to identify performance bottlenecks:

```bash
dev xdebug-console php -d xdebug.mode=profile myscript.php
```

Profile files are generated in `/tmp` inside the container.

## Troubleshooting

### IDE Not Connecting

Verify XDebug is loaded:
```bash
dev xdebug-console php -v
```

You should see "with Xdebug" in the output.

### Port Conflicts

Ensure port 9003 isn't blocked by your firewall and your IDE is listening on the correct port.

### Path Mapping Issues

Make sure your IDE's path mappings match your workspace structure. The container path is always `/data/workspace/...`
