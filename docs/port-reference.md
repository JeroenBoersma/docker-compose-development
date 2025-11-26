# Port Reference

This reference lists all ports used by services in the development environment.

## Core Services

| Service | Port(s) | Protocol | Access | Description |
|---------|---------|----------|--------|-------------|
| **nginx/ssl** | 80, 443 | HTTP/HTTPS | localhost | Web server and SSL proxy |
| **MySQL (db)** | 3306 | TCP | 127.0.0.1:3306 | Default MySQL/Percona database |
| **Redis** | 6379 | TCP | redis:6379 | Redis cache server (internal) |
| **MailHog SMTP** | 1025 | SMTP | mailcatch:1025 | Email testing SMTP (internal) |
| **MailHog Web** | 8025 | HTTP | localhost:8025 | MailHog web interface |

Access MailHog at: [http://mail.localhost](http://mail.localhost)

## PHP-FPM Services

| Service | Port | Protocol | Description |
|---------|------|----------|-------------|
| **php74** | 9000 | FastCGI | PHP 7.4 FPM |
| **php80** | 9000 | FastCGI | PHP 8.0 FPM |
| **php81** | 9000 | FastCGI | PHP 8.1 FPM |
| **php82** | 9000 | FastCGI | PHP 8.2 FPM |
| **php83** | 9000 | FastCGI | PHP 8.3 FPM |
| **php84** | 9000 | FastCGI | PHP 8.4 FPM |
| **php85** | 9000 | FastCGI | PHP 8.5 FPM |

Note: PHP containers are accessed internally via FastCGI, not directly exposed.

## Optional Services - Databases

| Service | Port(s) | Protocol | Access | Description |
|---------|---------|----------|--------|-------------|
| **MySQL 8 (db8)** | 3308 | TCP | 127.0.0.1:3308 | MySQL 8 database (alternative instance) |
| **MongoDB** | 27017 | TCP | mongo:27017 | MongoDB NoSQL database (internal) |
| **OpenSearch** | 9200 | HTTP | opensearch:9200 | OpenSearch search engine (internal) |

## Optional Services - Search & Monitoring

| Service | Port | Protocol | Access | Description |
|---------|------|----------|--------|-------------|
| **Elasticsearch** | 9200 | HTTP | elasticsearch:9200 | Elasticsearch 6.5.4 (internal) |
| **Elasticsearch 7** | 9200 | HTTP | elasticsearch:9200 | Elasticsearch 7.9.1 (internal) |
| **Elasticsearch HQ** | 5000 | HTTP | localhost:5000 | Elasticsearch monitoring UI |
| **ElasticVue** | 8080 | HTTP | localhost:8080 | Elasticsearch/OpenSearch web UI |
| **OpenSearch Dashboard** | 5601 | HTTP | localhost:5601 | OpenSearch Dashboard (Kibana alternative) |

## Optional Services - Message Queues

| Service | Port(s) | Protocol | Access | Description |
|---------|----------|----------|--------|-------------|
| **RabbitMQ AMQP** | 5672 | AMQP | rabbitmq:5672 | RabbitMQ message broker (internal) |
| **RabbitMQ Management** | 15672 | HTTP | localhost:15672 | RabbitMQ web management UI |

Access RabbitMQ at: [http://localhost:15672](http://localhost:15672)

## Optional Services - Development Tools

| Service | Port | Protocol | Access | Description |
|---------|------|----------|--------|-------------|
| **mongo-express** | 8081 | HTTP | localhost:8081 | MongoDB web interface |
| **FTP** | 21 | FTP | localhost:21 | FTP server for workspace access |

## Optional Services - Other

| Service | Port | Protocol | Access | Description |
|---------|------|----------|--------|-------------|
| **Varnish** | 80, 6081 | HTTP | varnish:80 | HTTP cache layer (internal) |
| **ngrok** | varies | HTTP/HTTPS | varies | Tunneling service (dynamic ports) |
| **Expose** | varies | HTTP/HTTPS | varies | Expose server (dynamic ports) |

## Debugging & Profiling Ports

| Service | Port | Protocol | Description |
|---------|------|----------|-------------|
| **XDebug** | 9003 | TCP | XDebug 3.x debugging protocol |
| **XDebug (legacy)** | 9000 | TCP | XDebug 2.x debugging protocol |
| **Blackfire** | 8707 | TCP | Blackfire profiling agent |

## Port Binding Notes

### External Binding (127.0.0.1)

Services bound to `127.0.0.1` are accessible only from the host machine:
- MySQL (3306, 3308)
- Web services (80, 443 via ssl proxy)
- Management UIs (8081, 15672, 5000, 8080)

### Internal Only

Services without published ports are accessible only from other containers:
- Redis (6379)
- MongoDB internal (27017)
- Elasticsearch/OpenSearch (9200)
- RabbitMQ AMQP (5672)
- MailHog SMTP (1025)

### Host Network Mode

Some services use host network mode and don't have fixed ports:
- ngrok
- expose

## Port Conflicts

### Common Conflicts

**Port 80/443:**
- **Conflict:** System web server (Apache, nginx)
- **Solution:** Stop system web server or change dev environment ports

**Port 3306:**
- **Conflict:** System MySQL/MariaDB
- **Solution:** Stop system MySQL or use MySQL 8 on port 3308

**Port 5672:**
- **Conflict:** System RabbitMQ
- **Solution:** Stop system RabbitMQ

### Checking Port Usage

See what's using a port:
```bash
sudo lsof -i :3306
sudo netstat -tlnp | grep :3306
```

### Changing Ports

To change ports, use `docker-custom.yml`:
```yaml
services:
  db:
    ports:
      - "127.0.0.1:3307:3306"  # Use 3307 instead of 3306
```

## Firewall Configuration

If using UFW firewall, allow necessary ports. See [ufw-firewall.md](ufw-firewall.md).

## Security Notes

### Localhost Binding

Most services are bound to `127.0.0.1`, making them accessible only from the local machine, not from the network. This is secure for development.

### Network Accessible Services

If you need network access (from other devices):
```yaml
services:
  db:
    ports:
      - "0.0.0.0:3306:3306"  # WARNING: Exposes to network
```

Only do this in trusted networks.

## Quick Reference

### Most Common Ports
- **Web**: http://localhost or http://*.localhost
- **MailHog**: http://mail.localhost
- **MySQL**: 127.0.0.1:3306
- **RabbitMQ**: http://localhost:15672

### From Application Code
- **MySQL**: host=`db`, port=`3306`
- **MySQL 8**: host=`db8`, port=`3306` (internal) or `127.0.0.1:3308` (external)
- **Redis**: host=`redis`, port=`6379`
- **Elasticsearch**: host=`elasticsearch`, port=`9200`
- **OpenSearch**: host=`opensearch`, port=`9200`
- **MongoDB**: host=`mongo`, port=`27017`
- **RabbitMQ**: host=`rabbitmq`, port=`5672`
- **Mail**: host=`mailcatch`, port=`1025`

## See Also

- [mysql-mailhog-redis-cronjobs.md](mysql-mailhog-redis-cronjobs.md) - Core service details
- [ufw-firewall.md](ufw-firewall.md) - Firewall configuration
- [environment-configuration.md](environment-configuration.md) - Service configuration
