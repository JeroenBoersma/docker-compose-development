
Docker-compose development
===

Quickly start developing locally with Nginx, PHP, Percona, mailcatcher and redis.

No mail is send externally, everything is catched by mailcatcher.


Base images
---

Currently the next images are used. Trying to rely on official images as much as possible.

- data -> busybox:latest
- mailcatcher -> schickling/mailcatcher:latest
- nginx -> nginx:latest
- percona -> percona:latest
- phpfpm -> php:5.4-fpm
- redis -> redis:latest


Installation
---

- Install [docker](https://docs.docker.com/)
- Install docker [compose](https://docs.docker.com/compose/install/)
- Clone this project 
  `git clone git@github.com:JeroenBoersma/docker-compose-development.git development`


Before
---

Tested under Linux. For Windows/Mac, take a look at the docks for boot2docker.
Stop all other local Webservers running on port 80/443.

First create a **percona\_data** container to keep your database data safe.
This way the database will never be swept away after a `docker-compose rm -v`

- If you don't want a persistent database, remove the `volumes\_from` in the db section.
- If you start from scratch.
  `docker run --name percona_data -v /var/lib/mysql busybox`
- If you are have a running percona database which you want to re-use. (be sure to stop it)
  `docker run --name percona_data --volumes_from [current_percona_container] busybox`

Start
---

- Run `docker-compose build` from the development directory, this will build the custom repositories
- Run `docker-compose up -d` from the development directory
- \*.dev > 127.0.0.1 (if you use boot2docker, use that ip)
    - dnsmasq
      add a file `/etc/dnsmasq.d/dev.conf` with `address=/.dev/127.0.0.1`
    - hosts
        - add `127.0.0.1 test.project.dev` to your hosts file `/etc/hosts`
        - add `127.0.0.1 mail.dev` to your hosts file `/etc/hosts`
- open your browser and type test.project.dev
- add your own new project in workspace `customer/project/htdocs` (no need to restart, this will work out of the box)
  open http://customer.project.dev/ in your browser (if you do not have dnsmasq, you have to add your hosts file).
- find all sent mail from your app by opening http://mail.dev/


Database
---

The default user/pass for the database is root/toor.
To manage database run `docker exec -it development_db_1 mysql -p`

You can access the database from your app by adding `db` as hostname and your create user/pass/database.


Redis
---

To use redis, use `redis` as hostname from your app.

To flush redis ` echo flushall | docker exec development_redis_1 redis-cli`


Console
---

If you want run a console php.
`docker exec development_phpfpm_1 su - app`

Cron
---

If you use cronjobs in your app, you can add the from your host machine.
`docker ps | grep development_phpfpm && docker exec development_phpfpm_1 su app [YOURCOMMANDHERE]`

For instance, if you must run a Magento cronjob.
`docker ps | grep development_phpfpm && docker exec development_phpfpm_1 su app magento/project/htdocs/cron.sh`

You can add these to your local cron.


Magento storecode
---

Being a Magento developer, you can extend your url by adding the storecode.
http://magento.project.storecode.dev/ will translate to workspace/magento/project/htdocs 
and will set the `MAGE_RUN_CODE` to storecode.

