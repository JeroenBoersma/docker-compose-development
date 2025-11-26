# Installation
## Prerequisites
Install docker engine and docker compose plugin, for more info check: https://docs.docker.com/engine/install/

```bash
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

### Add user to the docker group and reboot
```bash
sudo usermod -aG docker ${USER}
reboot
```

## Cloning
https://github.com/JeroenBoersma/docker-compose-development/tree/development-docker-compose-2/

```bash
git clone -b development-docker-compose-2 https://github.com/JeroenBoersma/docker-compose-development.git development

cd development
bin/dev setup
# press enter a few times and read instructions
# default php81
# setup your needs (elasticsearch/rabbitmq/etcetera)
# you can always run this again

# adding to your profile to use `dev` commands
bin/dev profile >> ~/.zshrc # or ~/.bashrc if you use bash
```

If you just installed zsh and your shell isn't changing to zsh, try logging in and out.

## Move the workspace directory to home
To avoid having the .git from the clone in your workspace, you can optionally move your workspace to your home directory.

```bash
cd

dev down --remove-orphans

dev volume rm workspace
mkdir workspace
dev volume workspace workspace

cdw
dev php-change php81 # if that's the default

dev up
```

## Make MySQL persistent in your development directory (optional)
This will destroy all current databases

```bash
cd
cd development

dev down --remove-orphans

dev volume rm mysql
mkdir mysql
dev volume mysql mysql

dev setup # this will add your user and correct settings (press enter to everything)
```

## Documentation

Comprehensive documentation is available in the `docs/` directory.

### Getting Started
- [Development Commands](docs/development-commands.md) - All available `dev` commands
- [Hosts and File Structure](docs/hosts-and-file-structure.md) - Project structure and hostname conventions
- [How to Use Different PHP Versions](docs/how-to-use-different-php-versions.md) - PHP version switching
- [F.A.Q.](docs/faq.md) - Frequently asked questions

### Core Services
- [MySQL, MailHog, Redis, and Cronjobs](docs/mysql-mailhog-redis-cronjobs.md) - Core service configuration
- [MySQL 8](docs/mysql8.md) - MySQL 8 setup and usage
- [Elasticsearch](docs/elasticsearch.md) - Elasticsearch 6.5.4 and 7.9.1 setup
- [OpenSearch](docs/opensearch.md) - OpenSearch setup and configuration
- [OpenSearch Dashboard](docs/opensearch-dashboard.md) - OpenSearch Dashboard UI
- [MongoDB](docs/mongodb.md) - MongoDB and mongo-express setup
- [RabbitMQ](docs/rabbitmq.md) - RabbitMQ message broker setup

### Development Tools
- [Node.js, NPM, and Yarn](docs/node-npm-yarn.md) - Frontend tooling and package managers
- [XDebug](docs/xdebug.md) - PHP debugging with XDebug
- [Varnish](docs/varnish.md) - HTTP caching with Varnish
- [FTP Server](docs/ftp.md) - FTP access to workspace
- [Git and SSH Integration](docs/git-ssh-integration.md) - Git commands and SSH key forwarding

### Configuration
- [Environment Configuration](docs/environment-configuration.md) - .env file and configuration markers
- [Docker Volumes](docs/docker-volumes.md) - Volume management and persistence
- [PHP Extensions](docs/php-extensions.md) - Managing PHP extensions
- [Custom Docker Compose Files](docs/custom-compose-files.md) - Customization with docker-custom.yml
- [Customize Docker Containers](docs/customize-docker-containers.md) - Container customization basics

### Monitoring & Tools
- [Monitoring Tools](docs/monitoring-tools.md) - Container and database monitoring
- [Search UI Tools](docs/search-ui-tools.md) - ElasticVue and Elasticsearch HQ
- [Port Reference](docs/port-reference.md) - Complete port assignments

### Performance & Optimization
- [Performance Tuning](docs/performance-tuning.md) - Optimization techniques
- [Backup and Restore](docs/backup-restore.md) - Backup strategies and restore procedures

### Profiling & Debugging
- [Configure Blackfire](docs/configure-blackfire.md) - Blackfire profiler setup

### Sharing & Networking
- [Sharing with the World via ngrok](docs/sharing-with-the-world-via-ngrok.md) - ngrok tunneling
- [BeyondCode Expose](docs/expose.md) - Expose server for sharing
- [UFW Firewall](docs/ufw-firewall.md) - Firewall configuration

### Advanced Topics
- [Advanced Docker Configuration](docs/advanced-docker-configuration.md) - UID/GID, build arguments, networks
- [Install Other PHP Versions](docs/install-other-php-versions.md) - Installing older PHP versions
- [Used Base Images](docs/used-base-images.md) - Docker image references

### Contributing
- [Code of Conduct](docs/code-of-conduct.md) - Contributor guidelines


