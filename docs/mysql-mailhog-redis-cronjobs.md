# Database
Make sure you have configured your desired root password in `conf/mysql`.
To manage your databases, run `./bin/dev myroot`

You can access the database in your app using `db` as hostname.

# MailHog

We use [Mailhog][1] to catch all outgoing e-mail (as long as you aren't using an external API).
You can even release the e-mail to a real mailserver, just click the release button in Mailhog you can setup and presto.
Goto [http://mail.locahost/][2] to see all catched mail.

# Redis

To access redis you can use `redis` as hostname in the config of your app.

# Cron

If you use cronjobs in your app, you can add them on your host machine.
It is recommend to add `./bin/dev` to the path before you implement this, as described in [1). Configure your environment.](../README.md#1-first-things-first)

E.g.: `*/5 * * * * dev ps | grep php | grep Up && dev console [YOURCOMMANDHERE]`

For instance, if you wish to run a Magento cronjob, then add the following to your local cronjob:
`*/5 * * * * dev ps | grep php | grep Up && dev console customer/project/htdocs/cron.sh`


[1]: https://github.com/mailhog/MailHog
[2]: http://mail.locahost/
