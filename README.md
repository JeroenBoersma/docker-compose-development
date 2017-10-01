[![Waffle.io - Issues in progress](https://badge.waffle.io/JeroenBoersma/docker-compose-development.png?label=in%20progress&title=In%20Progress)](https://waffle.io/JeroenBoersma/docker-compose-development?utm_source=badge)

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

Supports Magento 2 projects in PHP7 only, use `*.magento2.dev` to use a Magento 2 specific setup.
Webroot is pub only.

Add a file mapping in your IDE, `./workspace/customer/project` -> `/data/customer/project`

Xdebug
---

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
