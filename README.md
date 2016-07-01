
Docker-compose development
===

Quickly start of developing locally with Nginx, PHP, Blackfire, Percona, Mailcatcher and Redis.

No e-mail is send externally, everything is catched by mailcatcher.


Base images
---

Currently the next images are used. Trying to rely on official images as much as possible.

- blackfire -> blackfire/blackfire:latest
- data -> busybox:latest
- mailcatcher -> schickling/mailcatcher:latest
- nginx -> nginx:latest
- percona -> percona:latest
- php7 -> php:7.0-fpm
- php5 -> php:5.6-fpm
- redis -> redis:latest


Installation
---

- Install [docker](https://docs.docker.com/)
- Install docker [compose](https://docs.docker.com/compose/install/) >1.3.1
- Clone this project 
  `git clone git@github.com:JeroenBoersma/docker-compose-development.git development`


Before
---

Tested under Linux. For Windows/Mac, take a look at the docker beta(heard that good performances are met)
Stop all other local Webservers running on port 80/443.

Set-up your database credentials and Blackfire profile in the conf directory

- conf/mysql (`MYSQL\_ROOT\_PASSWORD=something`)
- conf/blackfire (from blackfire docs select **docker installation**, grab the exports section, paste it and remove export)

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

Default behavior is PHP7 and http://customer.project*.php5.dev*/ will call same project in PHP5.

Database
---

Set the desired root password in the conf/mysql section.
To manage database run `./bin/dev myroot`

You can access the database in your app use `db` as hostname.

Files will be saved in the mysql directory so it will be saved after destroying or recreating the containers.


Redis
---

To use redis, use `redis` as hostname in the config of your app.


Console
---

If you want run a console to run php commands.

- `./bin/dev console` - PHP7
- `./bin/dev php` - PHP7

- `./bin/dev console5` - PHP5
- `./bin/dev php5` - PHP5

Cron
---

If you use cronjobs in your app, you can add them on your host machine.
`docker ps | grep development_phpfpm && docker exec development_phpfpm_1 su app [YOURCOMMANDHERE]`

For instance, if you must run a Magento cronjob.
`docker ps | grep development_phpfpm && docker exec development_phpfpm_1 su app magento/project/htdocs/cron.sh`

You can add these to your local cron.


Magento storecode
---

Being a Magento developer, you can extend your url by adding the storecode.
http://magento.project.storecode.dev/ will translate to workspace/magento/project/htdocs 
and will set the `MAGE_RUN_CODE` to storecode.

