# Varnish

Varnish is an HTTP accelerator and caching layer that sits in front of your web server to dramatically improve performance.

## Setup

Enable Varnish during the initial setup:
```bash
dev setup
```

If you've already set up your environment, enable Varnish by creating the VCL configuration file:
```bash
cp build/dist/varnish/default.vcl conf/varnish.vcl
dev rebuild
```

## Configuration

Varnish uses VCL (Varnish Configuration Language) to define caching behavior. The default configuration file is located at `conf/varnish.vcl`.

### Cache Size

Set the cache size via environment variable in your `.env` file:
```bash
CACHE_SIZE=256M
```

Default cache size is typically 256MB.

## VCL Customization

### Import Custom VCL

To use a custom VCL file:
```bash
dev varnish-vcl-import /path/to/your/custom.vcl
```

### Disable VCL

To disable Varnish VCL:
```bash
dev varnish-vcl-disable
```

### Edit VCL

Edit the VCL configuration:
```bash
nano conf/varnish.vcl
```

After making changes, reload Varnish:
```bash
dev restart varnish
```

## Varnish Administration

Access Varnish admin commands:
```bash
dev varnishadm
```

Common varnishadm commands:
```bash
dev exec varnish varnishadm ban req.url '~' '.'       # Ban all cached content
dev exec varnish varnishadm param.show                # Show all parameters
dev exec varnish varnishadm ban.list                  # List active bans
```

Note: Based on the user's CLAUDE.md, you can run varnishadm locally with:
```bash
dev exec varnish varnishadm
```

## Usage with Magento 2

For Magento 2, you'll need a Magento-specific VCL. Example configuration in `conf/varnish.vcl`:

1. Generate Magento's VCL:
```bash
dev console bin/magento varnish:vcl:generate > conf/varnish.vcl
```

2. Restart Varnish:
```bash
dev restart varnish
```

3. Configure Magento to use Varnish:
   - **Stores** > **Configuration** > **Advanced** > **System** > **Full Page Cache**
   - Set **Caching Application** to "Varnish Cache"
   - Set Varnish host to `varnish`

## Testing Varnish

Check if Varnish is caching:
```bash
curl -I http://your-project.localhost
```

Look for the `X-Varnish` header in the response. If present, Varnish is working.

To see if a response is cached:
- `X-Cache: HIT` = Served from cache
- `X-Cache: MISS` = Not in cache, fetching from backend

## Troubleshooting

Check Varnish status:
```bash
dev ps | grep varnish
```

View Varnish logs:
```bash
dev logs varnish
```

Verify VCL syntax before restarting:
```bash
dev exec varnish varnishadm vcl.load test /etc/varnish/default.vcl
```
