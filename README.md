
# Docker-compose development

Quickly start of developing locally with Nginx, PHP, Blackfire, Percona, MailHog and Redis.

No e-mail is send externally, everything is catched by MailHog.
Look out if you are using sendgrid, mailchimp or similar mail API's, we do not catch those.


## Base images

Currently the next base images are used. Trying to rely on official images as much as possible.

- blackfire -> [blackfire/blackfire:latest](https://hub.docker.com/r/blackfire/blackfire/)
- nginx -> [nginx:alpine](https://hub.docker.com/r/_/nginx/)
- percona -> [percona:latest](https://hub.docker.com/r/_/percona/)
- php -> [srcoder/development-php:7.0-fpm](https://hub.docker.com/r/srcoder/development-php/)
- php5 -> [srcoder/development-php:5.6-fpm](https://hub.docker.com/r/srcoder/development-php/)
- php71 -> [srcoder/development-php:7.1-fpm](https://hub.docker.com/r/srcoder/development-php/)
- redis -> [redis:alpine](https://hub.docker.com/r/_/redis/)
- mailhog -> [mailhog/mailhog:latest](https://hub.docker.com/r/mailhog/mailhog/)
- mytop -> [srcoder/mytop:latest](https://hub.docker.com/r/srcoder/mytop/)
- ctop -> [wrfly/ctop](https://hub.docker.com/r/wrfly/ctop/)


## Installation

- Install [docker](https://docs.docker.com/)
- Install docker [compose](https://docs.docker.com/compose/install/) >1.6.1
- Clone this project
  `git clone git@github.com:JeroenBoersma/docker-compose-development.git development`

## Additional installation steps for OSX

- Install [Docker Sync](http://docker-sync.io/) and its dependencies.
- You need to install coreutils using Homebrew only to have realpath command. :)
  `brew install coreutils`

## Persistent data container

For running the database you need to create a new persistent data volume `docker volume create dockerdev-mysql-volume`

If you already where using this repo before(or want a local directory), you can map the existing volume with:
`docker volume create -o 'type=none' -o 'device='${PWD}'/mysql' -o 'o=bind' dockerdev-mysql-volume`

## Preparation

Tested under Linux. Also tested on OSX by a limited number of developers.
For Windows, take a look at the docker beta(heard that good performances are met)

Stop all other local Webservers running on port 80/443, stop all MySQL database servers on port 3306.

Set-up your database credentials(`conf/mysql`) and Blackfire(`conf/blackfire`) profile in the conf directory

- conf/mysql (`MYSQL_ROOT_PASSWORD=something`)

## Blackfire

Blackfire is optional, the library is already available in PHP, but not loaded by default.
To load blackfire, simply add a `conf/blackfire` file with content from the [Blackfire website](https://blackfire.io/docs/integrations/docker#documentation).
Copy/paste the contents from the first block in the configuration file and remove the `export ` from the beginning of the line.
`./bin/dev/down` and `./bin/dev/up` to load blackfire.

## Start

- run `docker-sync start` from the development directory (OSX only)
- run `./bin/dev up` from the development directory
- \*.dev > 127.0.0.1 (if you use boot2docker, use that ip)
    - dnsmasq
      add a file `/etc/dnsmasq.d/dev.conf` with `address=/.dev/127.0.0.1`
    - hosts
        - add `127.0.0.1 test.project.dev` to your hosts file `/etc/hosts`
        - add `127.0.0.1 mail.dev` to your hosts file `/etc/hosts`
- add your project in workspace `customer/project/htdocs` (no need to restart, this will work out of the box)
- open http://customer.project.dev/ in your browser (if you do not have dnsmasq, you have to add your hosts file manually).
- all outgoing mail is sent to http://mail.dev/

# PHP Versions

We support PHP 5.6.x, PHP 7.0.x, PHP 7.1.x. PHP 7.0 is the default.

To test PHP 7.1, use `*.php71.dev`. For PHP 5.6 use `*.php5.dev`
Same for `dev [COMMAND]`, just add `5` or `71` for php commands.

## Hosts and file structure

Everything is translated from `customer.project.dev` -> `workspace/customer/project/htdocs`.
For example; `iwant.coffee.dev` -> `workspace/iwant/coffee/htdocs`.

To be compatible with various webroots, we will lookup a few defaults.
Webroots -> `htdocs`, `httpdocs`, `public` or `pub`.

Support for Magento 1 projects in both PHP7 and PHP5, use `*.magento.dev` and `*.magento.php5.dev` to use a Magento specific setup.
Webroots + `magento`. You can also identify a MAGE_RUN_CODE, `customer.project.MAGE_RUN_CODE.magento.dev`

Support for Symfony in both PHP7 and PHP5, use `*.symfony.dev` to use a Symfony specific setup.
Webroots + `web`.

Support for Silex in both PHP7 and PHP5, use `*.silex.dev` to use a Silex specific setup.
Webroots + `web`.

Supports Magento 2 projects in PHP7 only, use `*.magento2.dev` to use a Magento 2 specific setup.
Webroot is `pub` only.

Add a file mapping in your IDE, `./workspace/customer/project` -> `/data/customer/project`

## Xdebug

Xdebug is enabled with support for remote debugging on your local machine.
It'll try to connect to the host 172.17.0.1:9000 by default.

## Dev commands

We supply several helpful commands to get of easily. `./bin/dev COMMAND` or just `dev COMMAND` if you've added the development to your $PATH.

To control your docker environment.

- `build [IMAGE]`
  re-build a image
- `config`
  show docker-compose configuration
- `down`
  destroy your local development environment, will not remove project/mysql files, only containers.
- `exec [CONTAINER] [OPTIONS]`
  execute commands in a specific container, for instance php or nginx
- `images`
  display used images
- `logs [CONTAINER]`
  show logs for a specific container
- `profile`
  show some useful commands to add to your SHELL
- `ps`
  show all running processes
- `restart [CONTAINER]`
  restart all or a specific container
- `start`
  start all exising container, will not create them if they don't exist(use `up` instead)
- `status`
  alias for ps
- `stop`
  stop all running containers
- `up`
  create/build/run all containers, bring your development to live
- `update`
  update/pull all used images from the web

There are also useful tools.

- `blackfire curl [URL]`
  The blackfire command to curl pages. Be sure you've setup blackfire correctly
- `composer [COMMANDS]` `composer5 [COMMANDS]`
  composer docker implementation, also runs in own container.
- `console` `console5`
  open a console inside your PHP containers.
- `magerun [COMMANDS]`
  run magerun commands on your Magento projects
- `magerun2 [COMMANDS]`
  run magerun2 commands on your Magento projects
- `myroot [OPTIONS]`
  run mysql as root.
- `mysql [OPTIONS]`
  run mysql as you, current user
- `mysqldump [OPTIONS]`
  run mysqldump as you, current user
- `mytop`
  run mytop as you, current user to monitor MySQL processes
- `top`
  monitor your running containers and see how much resources they are eating
- `php [OPTIONS]`
  run php commands

You can run these commands from within your workspace directories.
For example: `cd workspace/test/project/htdocs` `../../../../bin/dev php info.php` (or `dev php info.php` if you've added the bin directory to your path)

So you can also import data to mysql with `./bin/dev mysql database < dump.sql` or dump `./bin/mysqldump database > dump.sql`.

## Database

Set the desired root password in the conf/mysql section.
To manage database run `./bin/dev myroot`

You can access the database in your app use `db` as hostname.

Files will be saved in the mysql directory so it will be saved after destroying or recreating the containers.

## MailHog

We use [Mailhog](https://github.com/mailhog/MailHog) to catch all outgoing e-mail(if you aren't using an external API).
You can even release the e-mail to a real mailserver, just click the release button in Mailhog you can setup and presto.
Goto http://mail.dev/ to see all catched mail.

## Redis

To use redis, use `redis` as hostname in the config of your app.


## Cron

If you use cronjobs in your app, you can add them on your host machine.
I would recommend to add dev to the path before you implement this.

`*/5 * * * * dev ps | grep php | grep Up && dev console [YOURCOMMANDHERE]`

For instance, if you must run a Magento cronjob.
`*/5 * * * * dev ps | grep php | grep Up && dev console customer/project/htdocs/cron.sh`

You can add these to your local cron.

## Customization

Of coarse you would love day to day updates and still have room to add your own changes.
Just add a `docker-custom.yml`, add `version: '2'` at the top and override whatever you want.

`docker-custom.yml` and the `./custom` directory are excluded from git.

The next example for the default php, add the next `docker-custom.yml` file:

```
version: '2'

services:
    php:
        build: custom/php7
```

This won't build the regular php7 directory, instead it will run build in the custom directory.
So, next up you copy the php/Dockerfile and add your own additions which will be build everytime updates are available.



