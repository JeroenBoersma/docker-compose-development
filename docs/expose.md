# BeyondCode Expose

BeyondCode Expose is an open-source alternative to ngrok for sharing your local development environment with the outside world. It's useful for webhooks, external testing, and client demos.

## Setup

Enable Expose during the initial setup:
```bash
dev setup
```

If you've already set up your environment:
```bash
mkdir -p conf/expose
dev rebuild
```

## Usage

Share a specific hostname:
```bash
dev expose your-project.localhost
```

Expose will:
1. Create a tunnel to your local environment
2. Provide a public URL
3. Forward all traffic to your local hostname

## Expose vs ngrok

Both Expose and ngrok provide similar functionality. Key differences:

**Expose:**
- Open-source
- Self-hosted option available
- Free tier with fewer restrictions
- Integrated into dev environment

**ngrok:**
- More established
- Better documentation
- More features in paid tiers
- See [sharing-with-the-world-via-ngrok.md](sharing-with-the-world-via-ngrok.md)

## Configuration

Expose runs in host network mode, allowing it to access your local services directly.

## Common Use Cases

### Webhook Testing

Test webhooks from external services:
```bash
dev expose shop.localhost
```

Share the provided URL with the webhook provider (e.g., payment gateway, Shopify, etc.)

### Client Demos

Show work-in-progress to clients:
```bash
dev expose demo.localhost
```

Send the public URL to your client for review.

### Mobile Testing

Test your site on mobile devices without network configuration:
```bash
dev expose mysite.localhost
```

Access the public URL from your mobile device.

## Security Considerations

When exposing your local environment:
- Don't expose production credentials or real customer data
- Use temporary database dumps for demos
- Be aware that anyone with the URL can access your site
- Close the tunnel when done

## Troubleshooting

Check if Expose is running:
```bash
dev ps | grep expose
```

View Expose logs:
```bash
dev logs expose
```

If the tunnel fails:
- Verify your hostname is accessible locally
- Check that the SSL proxy is running: `dev ps | grep ssl`
- Ensure no firewall is blocking outbound connections

## Alternative: ngrok

If you prefer ngrok, see [sharing-with-the-world-via-ngrok.md](sharing-with-the-world-via-ngrok.md) for setup instructions.
