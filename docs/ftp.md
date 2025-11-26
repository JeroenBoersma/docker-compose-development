# FTP Server

An FTP server can be enabled to provide FTP access to your workspace directory. This is useful for legacy applications or tools that require FTP connectivity.

## Setup

Enable the FTP server during setup:
```bash
dev setup
```

If you've already set up your environment:
```bash
mkdir -p conf/ftp
dev rebuild
```

## Configuration

The FTP server provides access to your workspace directory at `/data`.

### Connection Details

- **Host**: `localhost`
- **Port**: `21` (default FTP port)
- **Protocol**: FTP (not SFTP)

### Credentials

FTP credentials depend on the FTP server configuration. Check the FTP container build for specific authentication settings:
```bash
cat build/dist/ftp/Dockerfile
```

## Usage

### FTP Clients

You can connect using any FTP client:
- FileZilla
- WinSCP
- Command-line FTP
- Your IDE's built-in FTP

### Command-Line FTP

Connect via command line:
```bash
ftp localhost
```

## Security Note

FTP transmits data in plain text, including credentials. This FTP server is intended for development environments only.

For production-like workflows, consider using:
- SFTP instead of FTP
- Direct file mounting
- rsync over SSH

## Troubleshooting

Check if the FTP server is running:
```bash
dev ps | grep ftp
```

View FTP server logs:
```bash
dev logs ftp
```

Test FTP connectivity:
```bash
ftp localhost
```

If you cannot connect, ensure the FTP configuration marker exists:
```bash
ls conf/ftp
```
