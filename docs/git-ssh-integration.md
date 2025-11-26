# Git and SSH Integration

The development environment includes Git support and automatic SSH key forwarding, allowing you to use Git and authenticate with remote services from within containers.

## Git Command

Run Git commands from your project directory:
```bash
dev git status
dev git add .
dev git commit -m "message"
dev git push
```

The `dev git` command:
- Runs Git inside the PHP container
- Uses your workspace directory as the working directory
- Forwards your SSH agent for authentication
- Preserves your user context

## SSH Key Forwarding

SSH keys are automatically forwarded from your host to the containers when available.

### How It Works

If the `SSH_AUTH_SOCK` environment variable is set on your host, the environment automatically:
1. Detects your SSH agent
2. Mounts the SSH auth socket into containers
3. Sets up SSH agent forwarding

### Prerequisites

Start your SSH agent and add your key:
```bash
eval $(ssh-agent)
ssh-add ~/.ssh/id_rsa
```

Or add to your shell profile (`~/.bashrc` or `~/.zshrc`):
```bash
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval $(ssh-agent -s)
    ssh-add ~/.ssh/id_rsa
fi
```

### Verify SSH Forwarding

Check if SSH agent is available in container:
```bash
dev console
echo $SSH_AUTH_SOCK
ssh-add -l
```

You should see your SSH keys listed.

### Using SSH in Containers

Clone repositories:
```bash
dev console
cd /data/workspace/customer/project
git clone git@github.com:user/repo.git
```

Access remote servers:
```bash
dev console
ssh user@remote-server
```

## Git Configuration

### Global Git Config

Your Git configuration from the host is not automatically available in containers. Set it up:

```bash
dev git config --global user.name "Your Name"
dev git config --global user.email "your@email.com"
```

### Per-Project Git Config

In your project:
```bash
cd workspace/customer/project
dev git config user.name "Your Name"
dev git config user.email "your@email.com"
```

### Git Aliases

Create helpful aliases:
```bash
dev git config --global alias.co checkout
dev git config --global alias.br branch
dev git config --global alias.ci commit
dev git config --global alias.st status
```

## Common Git Workflows

### Clone a Repository

```bash
cd workspace
dev git clone git@github.com:user/repo.git customer/project
```

### Daily Workflow

```bash
cd workspace/customer/project
dev git pull
# make changes
dev git add .
dev git commit -m "Description of changes"
dev git push
```

### Branch Management

```bash
dev git checkout -b feature-branch
dev git push -u origin feature-branch
dev git checkout main
dev git branch -d feature-branch
```

## Composer with Private Repositories

When using Composer with private Git repositories, SSH forwarding allows authentication:

```bash
dev console
composer require organization/private-package
```

Composer will use your forwarded SSH keys to authenticate.

### GitHub/GitLab Tokens

Alternatively, configure Composer with access tokens:
```bash
dev console
composer config --global github-oauth.github.com YOUR_TOKEN
```

## SSH Config Files

To use custom SSH configurations, mount your SSH config:

In `docker-custom.yml`:
```yaml
version: '2'

services:
  php:
    volumes:
      - ~/.ssh/config:/root/.ssh/config:ro
```

## Troubleshooting

### SSH Authentication Failed

Verify SSH agent is running:
```bash
echo $SSH_AUTH_SOCK
ssh-add -l
```

Add your key if needed:
```bash
ssh-add ~/.ssh/id_rsa
```

Restart containers:
```bash
dev restart
```

### Git Command Not Found

Ensure you're using `dev git`, not just `git`:
```bash
dev git status  # Correct
```

### Permission Denied (publickey)

Test SSH connection:
```bash
dev console
ssh -T git@github.com
```

Verify your key is in the agent:
```bash
dev console
ssh-add -l
```

### Git Asking for Username/Password

You're using HTTPS instead of SSH. Clone with SSH:
```bash
# Not this:
dev git clone https://github.com/user/repo.git

# Use this:
dev git clone git@github.com:user/repo.git
```

Or convert existing repository:
```bash
dev git remote set-url origin git@github.com:user/repo.git
```

## Advanced: Multiple SSH Keys

If you use different SSH keys for different services:

Create `~/.ssh/config`:
```
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa_github

Host gitlab.com
    HostName gitlab.com
    User git
    IdentityFile ~/.ssh/id_rsa_gitlab
```

Add all keys to agent:
```bash
ssh-add ~/.ssh/id_rsa_github
ssh-add ~/.ssh/id_rsa_gitlab
```

## See Also

- [advanced-docker-configuration.md](advanced-docker-configuration.md) - UID/GID and build arguments
- [custom-compose-files.md](custom-compose-files.md) - Mounting custom volumes
