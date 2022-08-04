# Docker Development stack

Docker-compose-development aims to be a plug 'n play setup for you to quickly start developing locally with services as [NGINX][4], [PHP][5], [Blackfire][6], [Percona][7], [MailHog][8] and more!

Also, it contains different configurations for use with [Symfony][9], [Silex][10], [Magento 1 & 2][11], on PHP5 / PHP7 and with [XDEBUG][12] enabled.

We follow a [Code of Conduct](docs/code-of-conduct.md).

## Table of Contents
* [Prerequisites.](#prerequisites)
* [How to get started.](#how-to-get-started)
	* [1). Configure your environment.](#1-configure-your-environment)
	* [2). Configure your hostnames...](#2-configure-your-hostnames)
		* [By using DNSMASQ.](#by-using-dnsmaws)
		* [Or by using the hostfile.](#or-by-using-the-hostfile)
	* [3). Now, setup your projects!](#3-now-setup-your-projects)
* [Update your existing installation](#update)
* [But wait, there is more!](#but-wait-there-is-more)
    * [Development Commands](docs/development-commands.md)
    * [ElasticSearch](docs/elasticsearch.md)
    * [MySQL, MailHog, Redis, Cronjobs](docs/mysql-mailhog-redis-cronjobs.md)
    * [Used (base) images](docs/used-base-images.md)
    * [Customize Docker Containers](docs/customize-docker-containers.md)
    * [Configure Blackfire](docs/configure-blackfire.md)
    * [How to use different PHP versions](docs/how-to-use-different-php-versions.md)
		* [Hosts and file structure](docs/hosts-and-file-structure.md)
		* [Sharing with the world](docs/sharing-with-the-world-via-ngrok.md)
		* [Implement a new or old PHP version](docs/installing-unsupported-php-versions.md)
    * [F.A.Q.](docs/faq.md)
    * [UFW firewall](docs/ufw-firewall.md)

## Prerequisites
Before continuing you must have the following installed and working correctly:

 - [Docker][1]
 - [Docker-compose][2] (**1.12.0** or above)

If you are on Linux, you **must** follow these steps first; [Docker Linux Post install](https://docs.docker.com/engine/install/linux-postinstall/)

**OSX users** should also install:

 - [Docker Sync][3] and its dependencies
 - Coreutils using Homebrew `brew install coreutils`

 - Make sure that port 80/443 and 3306 are not being used by other services.
`sudo netstat -tupln|egrep '80|443|3306'`

**WSL users** 
- Setup docker using [https://nickjanetakis.com/blog/setting-up-docker-for-windows-and-wsl-to-work-flawlessly](https://nickjanetakis.com/blog/setting-up-docker-for-windows-and-wsl-to-work-flawlessly)
- should setup the SSH_AUTH_SOCK variable
Add the following to `~/.bashrc`:
```
# ssh-agent configuration
if [ -z "$(pgrep ssh-agent)" ]; then
    rm -rf /tmp/ssh-*
    eval $(ssh-agent -s) > /dev/null
else
    export SSH_AGENT_PID=$(pgrep ssh-agent)
    export SSH_AUTH_SOCK=$(find /tmp/ssh-* -name agent.*)
fi

if [ "$(ssh-add -l)" == "The agent has no identities." ]; then
    ssh-add
fi
```

# How to get started
Make sure that you have the prerequisites installed and running correctly before proceeding.

## 1). Configure your environment
 1. Clone this repository:
```
git clone git@github.com:JeroenBoersma/docker-compose-development.git development && cd development
```
 2. Run `bin/dev setup`
This will automaticly create a root user with a random password and adds your user with restricted rights.


* persistant MySQL on a location of your choice.
If you were already using this repository before (or want a local directory), you can map the existing volume with:
```
mkdir -p mysql;
docker volume create -o 'type=none' -o 'device='${PWD}'/mysql' -o 'o=bind' dockerdev-mysql-volume
```
Or, if you are on OSX:
```
docker-sync start
```

A optional, but recommended, step to take is to add the provided `.bin/dev` command to your system so you can use its commands anywhere you like.

 1. Run `./bin/dev profile` from the development folder.
 2. Copy the output into `~/.bashrc` `~/.bash_aliases` `~/.zshrc`, on your own preference.
 3. Log out and log back in for this to take effect. You could also just source the new files in your current terminal `. ~/.bashrc`.

If succeeded you can now use `dev <command>` from anywhere.
You can also just type `cdw` which will take you to your workspace directory.

## 2). Configure your hostnames...
There are several ways of configuring hostnames.

### By using DNSMASQ (preferred)
Only applies if you have DNSMASQ installed, otherwiste continue to use the hostfile instead.

Create a file `/etc/dnsmasq.d/dev.conf` and copy the following as its content:
`address=/.localhost/127.0.0.1`

#### For Windows
Use Acrylic DNS Proxy. For more information check the website [http://mayakron.altervista.org/wikibase/show.php?id=AcrylicHome](http://mayakron.altervista.org/wikibase/show.php?id=AcrylicHome)

### Or by using the hostfile
Add a hostname entry for each of your projects manually to `/etc/hosts`, e.g.:
`127.0.0.1 mail.localhost`
`127.0.0.1 test.project.localhost`

You should now be able to browse to `http://test.project.localhost/info.php` and get a phpinfo() output.

## 3). Now, setup your projects!
Inside the development folder you will find a folder called `workspace`. The folders follow a certain structure, as described below:
`customer/project/htdocs`

> For **WSL**
>
> Docker for Windows automatically mounts to `C:\workspace`. You'll find your workspace there. To change this, update `docker-compose-wsl.yml`

You will notice that this has a 1-on-1 relation to the hostname provided in your hostfile:
`workspace/test/project/htdocs` => `https://test.project.localhost/`

Other examples are:
- `workspace/iwant/coffee/htdocs` => `https://iwant.coffee.localhost/`
- `workspace/iwant/beer/htdocs` => `https://iwant.beer.localhost/`
- `workspace/nomore/soup4you/htdocs` => `https://nomore.soup4you.localhost/`

To be compatible with various projects, we have included the following definitions as webroots:

 - `htdocs`
 - `httpdocs`
 - `public`
 - `pub`
 - `web`
 - `magento`

You can read more about project webroots in the [Hosts and File structure](docs/hosts-and-file-structure.md) documentation.

## Xdebug
Xdebug is enabled with support for remote debugging on your local machine.
It will try to connect to the host `172.17.0.1:9000` by default.
Make sure to add a file mapping in your IDE:
`./workspace/customer/project` => `/data/customer/project`

# Update your existing installation

To update your existing installation, follow these steps:

- go to the development directory
- `git pull origin master`
- `bin/dev rebuild`
- `bin/dev setup`


# But wait, there is more!
* [Development Commands](docs/development-commands.md)
* [MySQL, MailHog, Redis, Cronjobs](docs/mysql-mailhog-redis-cronjobs.md)
* [Used (base) images](docs/used-base-images.md)
* [Customize Docker Containers](docs/customize-docker-containers.md)
* [Configure Blackfire](docs/configure-blackfire.md)
* [Install other PHP versions](docs/install-other-php-versions.md)
* [Hosts and file structure](docs/hosts-and-file-structure.md)
* [F.A.Q.](docs/faq.md)

[1]: https://docs.docker.com
[2]: https://docs.docker.com/compose/install/
[3]: http://docker-sync.io/
[4]: https://nginx.org/en/
[5]: https://secure.php.net/
[6]: https://blackfire.io/
[7]: https://www.percona.com/
[8]: https://github.com/mailhog/MailHog
[9]: https://symfony.com/
[10]: https://silex.sensiolabs.org/
[11]: https://magento.com/
[12]: https://xdebug.org/
