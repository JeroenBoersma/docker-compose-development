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
* [But wait, there is more!](#but-wait-there-is-more)
    * [Development Commands](docs/development-commands.md)
    * [MySQL, MailHog, Redis, Cronjobs](docs/mysql-mailhog-redis-cronjobs.md)
    * [Used (base) images](docs/used-base-images.md)
    * [Customize Docker Containers](docs/customize-docker-containers.md)
    * [Configure Blackfire](docs/configure-blackfire.md)
    * [How to use different PHP versions](docs/how-to-use-different-php-versions.md)
		* [Hosts and file structure](docs/hosts-and-file-structure.md)
		* [Sharing with the world](docs/sharing-with-the-world-via-ngrok.md)
    * [F.A.Q.](docs/faq.md)

## Prerequisites
Before continuing you must have the following installed and working correctly:

 - [Docker][1]
 - [Docker-compose][2] (**1.12.0** or above)

**OSX users** should also install:

 - [Docker Sync][3] and its dependencies
 - Coreutils using Homebrew `brew install coreutils`

 - Make sure that port 80/443 and 3306 are not being used by other services.
`sudo netstat -tupln|egrep '80|443|3306'`

# How to get started
Make sure that you have the prerequisites installed and running correctly before proceeding.

## 1). Configure your environment
 1. Clone this repository:
```
git clone git@github.com:JeroenBoersma/docker-compose-development.git development
```
 2. Create a new persistent data volume with:
```
docker volume create --name dockerdev-mysql-volume
```
Or, if you already were using this repository before (or want a local directory), you can map the existing volume with:
```
docker volume create -o 'type=none' -o 'device='${PWD}'/mysql' -o 'o=bind' dockerdev-mysql-volume
```
 3. Configure you MySQL credentials by editing [conf/mysql](conf/mysql).
 4. Start your containers!
 ```
 ./bin/dev up
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
`address=/.dev/127.0.0.1`

### Or by using the hostfile
Add a hostname entry for each of your projects manually to `/etc/hosts`, e.g.:
`127.0.0.1 mail.dev`
`127.0.0.1 test.project.dev`

You should now be able to browse to `http://test.project.dev/info.php` and get a phpinfo() output.

# # 3). Now, setup your projects!
Inside the development folder you will find a folder called `workspace`. The folders follow a certain structure, as described below:
`customer/project/htdocs`

You will notice that this has a 1-on-1 relation to the hostname provided in your hostfile:
`workspace/test/project/htdocs` => `http://test.project.dev`

Other examples are:
`workspace/iwant/coffee/htdocs` => `http://iwant.coffee.dev`
`workspace/iwant/beer/htdocs` => `http://iwant.beer.dev`
`workspace/nomore/soup4you/htdocs` => `http://nomore.soup4you.dev`

To be compatible with various projects, we have included the following definitions as webroots:

 - `htdocs`
 - `httpdocs`
 - `public`
 - `pub`

You can read more about project webroots in the [Hosts and File structure](docs/hosts-and-file-structure.md) documentation.

## Xdebug
Xdebug is enabled with support for remote debugging on your local machine.
It will try to connect to the host `172.17.0.1:9000` by default.
Make sure to add a file mapping in your IDE:
`./workspace/customer/project` => `/data/customer/project`

# But wait, there is more!
* [Development Commands](docs/development-commands.md)
* [MySQL, MailHog, Redis, Cronjobs](docs/mysql-mailhog-redis-cronjobs.md)
* [Used (base) images](docs/used-base-images.md)
* [Customize Docker Containers](docs/customize-docker-containers.md)
* [Configure Blackfire](docs/configure-blackfire.md)
* [How to use different PHP versions](docs/how-to-use-different-php-versions.md)
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
