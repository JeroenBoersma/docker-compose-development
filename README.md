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



