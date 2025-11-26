# F.A.Q.

## Where is my mail going? / I am not receiving my mail?
No e-mail is send externally, everything is catched by MailHog.
Be aware if you are using sendgrid, mailchimp or similar mail API's, we do not catch those.

Access MailHog at [http://mail.localhost](http://mail.localhost) to see all caught emails.

## How to configure MySQL

MySQL configuration can be customized in `conf/mysql/my.cnf`:
```bash
mkdir -p conf/mysql
nano conf/mysql/my.cnf
```

Set the root password in your `.env` file or during `dev setup`.

For more details, see [mysql-mailhog-redis-cronjobs.md](mysql-mailhog-redis-cronjobs.md).

## How to configure Blackfire

Create a `conf/blackfire` file with your Blackfire credentials from [blackfire.io](https://blackfire.io):
```bash
BLACKFIRE_CLIENT_ID=your-id
BLACKFIRE_CLIENT_TOKEN=your-token
BLACKFIRE_SERVER_ID=your-server-id
BLACKFIRE_SERVER_TOKEN=your-server-token
```

Then restart: `dev down && dev up`

For complete setup instructions, see [configure-blackfire.md](configure-blackfire.md).

## What PHP versions are supported?

The environment supports PHP 7.4, 8.0, 8.1, 8.2, 8.3, 8.4, and 8.5. The default is PHP 8.2.

Switch PHP versions using marker files:
```bash
cd workspace/customer/project
touch .php83  # Use PHP 8.3 for this project
```

See [how-to-use-different-php-versions.md](how-to-use-different-php-versions.md) for details.

## How do I enable optional services?

Enable services during setup with `dev setup`, or manually:
```bash
mkdir -p conf/servicename  # e.g., conf/elasticsearch, conf/rabbitmq
dev rebuild
```

Available optional services include: Elasticsearch, OpenSearch, RabbitMQ, MongoDB, Varnish, MySQL 8, and more.

## Where are my files stored?

By default, your projects are in the `workspace/` directory. The exact location depends on your setup:
- **Local directory**: `~/development/workspace/`
- **Docker volume**: Use `docker volume inspect dockerdev-workspace-volume`

Database files are similarly in `mysql/` or a Docker volume.

See [docker-volumes.md](docker-volumes.md) for volume management.

## How do I debug with XDebug?

Use the XDebug console command:
```bash
dev xdebug-console
```

Then configure your IDE to listen on port 9003 and set up path mappings from your local project to `/data/workspace/customer/project`.

See [xdebug.md](xdebug.md) for complete setup instructions.

## Can I use multiple MySQL versions?

Yes. The default MySQL 5.7/Percona runs on port 3306. You can also enable MySQL 8 on port 3308:
```bash
mkdir -p conf/mysql8
dev rebuild
```

Connect to MySQL 8 using `127.0.0.1:3308` from your host or `db8:3306` from containers.

See [mysql8.md](mysql8.md) for details.

## What monitoring tools are available?

Several monitoring tools are available:
- `dev top` - Container resource monitoring
- `dev mytop` - MySQL process monitoring
- ctop - Enhanced container monitoring
- Elasticsearch HQ - Elasticsearch monitoring UI (localhost:5000)
- ElasticVue - Modern search engine UI (localhost:8080)
- RabbitMQ Management - Queue management (localhost:15672)

See [monitoring-tools.md](monitoring-tools.md) for more details.

## How do I share my environment externally?

Use ngrok or BeyondCode Expose to create a tunnel:
```bash
dev ngrok your-project.localhost
```

Or:
```bash
dev expose your-project.localhost
```

This provides a public URL that forwards to your local environment.

See [sharing-with-the-world-via-ngrok.md](sharing-with-the-world-via-ngrok.md) and [expose.md](expose.md).

## How do I backup my databases?

Use mysqldump:
```bash
dev mysqldump database_name > backup.sql
```

Restore with:
```bash
dev mysql database_name < backup.sql
```

For complete backup strategies, see [backup-restore.md](backup-restore.md).

## How do I improve performance?

Key optimizations:
- Use Composer 2: `dev composer2`
- Use Docker volumes instead of bind mounts (macOS/Windows)
- Increase Docker Desktop resources (CPUs, memory)
- Enable production mode in Magento 2
- Configure MySQL memory settings

See [performance-tuning.md](performance-tuning.md) for comprehensive optimization techniques.

## Where can I find documentation?

All documentation is in the `docs/` directory. Key documents:
- [README.md](../README.md) - Getting started
- [development-commands.md](development-commands.md) - Command reference
- [hosts-and-file-structure.md](hosts-and-file-structure.md) - Project structure

For a complete list, see the Documentation section in [README.md](../README.md).
