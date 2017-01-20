
Docker-compose development
===

Quickly start of developing locally with Nginx, PHP, Blackfire, Percona, Mailcatcher and Redis.

No e-mail is send externally, everything is catched by Mailhog.
Look out if you are using sendgrid, mailchimp or similar mail API's, we do not catch those.


Base images
---

Currently the next base images are used. Trying to rely on official images as much as possible.

- blackfire -> blackfire/blackfire:latest
- composer -> composer/composer:latest
- nginx -> nginx:alpine
- percona -> percona:latest
- php5 -> php:5.6-fpm
- php7 -> php:7.1-fpm
- redis -> redis:latest
- capistrano -> ruby:latest
- mailhog -> mailhog/mailhog:latest
- mytop -> srcoder/mytop:latest


Installation
---

- Install [docker](https://docs.docker.com/)
- Install docker [compose](https://docs.docker.com/compose/install/) >1.6.1
- Clone this project 
  `git clone git@github.com:JeroenBoersma/docker-compose-development.git development`


Before
---

Tested under Linux. For Windows/Mac, take a look at the docker beta(heard that good performances are met)
Stop all other local Webservers running on port 80/443.

Set-up your database credentials and Blackfire profile in the conf directory

- conf/mysql (`MYSQL_ROOT_PASSWORD=something`)

Blackfire
---

Blackfire is optional, the library is already available in PHP, but not loaded by default.
To load blackfire, simply add a `conf/blackfire` file with content from the [Blackfire website](https://blackfire.io/docs/integrations/docker#documentation).
Copy/paste the contents from the first block in the configuration file and remove the `export ` from the beginning of the line.
`./bin/dev/down` and `./bin/dev/up` to load blackfire.

Start
---

- Run `./bin/dev up` from the development directory
- \*.dev > 127.0.0.1 (if you use boot2docker, use that ip)
    - dnsmasq
      add a file `/etc/dnsmasq.d/dev.conf` with `address=/.dev/127.0.0.1`
    - hosts
        - add `127.0.0.1 test.project.dev` to your hosts file `/etc/hosts`
        - add `127.0.0.1 mail.dev` to your hosts file `/etc/hosts`
- add your project in workspace `customer/project/htdocs` (no need to restart, this will work out of the box)
- open http://customer.project.dev/ in your browser (if you do not have dnsmasq, you have to add your hosts file manually).
- all outgoing mail is sent to http://mail.dev/

Hosts and file structure
---

Everything is translated from `customer.project.dev` -> `workspace/customer/project/htdocs`.
For example; `iwant.coffee.dev` -> `workspace/iwant/coffee/htdocs`.

To be compatible with various webroots, we will lookup a few defaults.
Webroots -> `htdocs`, `httpdocs`, `public` or `pub`.

Support for PHP5, PHP7 is the default, use `*.php5.dev` to run the same project in PHP5.

Support for Magento 1 projects in both PHP7 and PHP5, use `*.magento.dev` and `*.magento.php5.dev` to use a Magento specific setup.
Webroots + `magento`.

Support for Symfony in both PHP7 and PHP5, use `*.symfony.dev` and `*.symfony.php5.dev` to use a Symfony specific setup.
Webroots + web.

Support for Silex in both PHP7 and PHP5, use `*.silex.dev` and `*.silex.php5.dev` to use a Silex specific setup.
Webroots + web.

Supports Magento 2 projects in PHP7 only, use `*.magento2.dev` to use a Magento 2 specific setup.
Webroot is pub only.

Add a file mapping in your IDE, `./workspace/customer/project` -> `/data/customer/project`

Xdebug
---

Xdebug is enabled with support for remote debugging on your local machine.
It'll try to connect to the host 172.17.0.1:9000 by default.

Dev commands
---

We supply several helpful commands to get of easily. `./bin/dev COMMAND` or just `dev COMMAND` if you've added the development to your $PATH.

To control your docker environment.

- `build [IMAGE]`
  re-build a image
- `down`
  destroy your local development environment, will not remove project/mysql files, only containers.
- `exec [CONTAINER]`
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
  update all linked images from the web

There are also useful tools.

- `blackfire curl [URL]`
  The blackfire command to curl pages. Be sure you've setup blackfire correctly
- `cap [ACTIONS]`
  capistrano docker implementation, runs in own container.
- `composer [COMMANDS]`
  composer docker implementation, also runs in own container.
- `console` `console5`
  open a console inside your PHP containers.
- `magerun [COMMANDS]` `magerun5 [COMMANDS]`
  run magerun commands on your Magento projects
- `myroot [OPTIONS]`
  run mysql as root.
- `mysql [OPTIONS]`
  run mysql as you, current user.
- `mysqldump [OPTIONS]`
  run mysqldump as you, current user.
- `php [OPTIONS]` `php5 [OPTIONS]`
  run php commands

You can run these commands from within your workspace directories.
For example: `cd workspace/test/project/htdocs` `../../../../bin/dev php info.php` (or `dev php info.php` if you've added the bin directory to your path)

So you can also import data to mysql with `./bin/dev mysql database < dump.sql` or dump `./bin/mysqldump database > dump.sql`.

Because PHP7 should be the default now, I've created shorthands for `./bin/php` but not for php5 use `./bin/dev php5` for that.

Database
---

Set the desired root password in the conf/mysql section.
To manage database run `./bin/dev myroot`

You can access the database in your app use `db` as hostname.

Files will be saved in the mysql directory so it will be saved after destroying or recreating the containers.


Redis
---

To use redis, use `redis` as hostname in the config of your app.


Cron
---

If you use cronjobs in your app, you can add them on your host machine.
I would recommend to add dev to the path before you implement this.

`*/5 * * * * dev ps | grep php7 | grep Up && dev console [YOURCOMMANDHERE]`

For instance, if you must run a Magento cronjob.
`*/5 * * * * dev ps | grep php7 | grep Up && dev console customer/project/htdocs/cron.sh`

You can add these to your local cron.

