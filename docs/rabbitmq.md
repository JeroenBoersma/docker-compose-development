# RabbitMQ

RabbitMQ is a message broker that enables applications to communicate through message queues. It comes with a web-based management interface.

## Setup

Enable RabbitMQ during the initial setup:
```bash
dev setup
```

If you've already set up your environment, enable RabbitMQ by creating a configuration marker:
```bash
mkdir -p conf/rabbitmq
dev rebuild
```

## Configuration

To connect to RabbitMQ from your applications, use:
- **Host**: `rabbitmq`
- **Port**: `5672` (AMQP protocol)
- **Management Port**: `15672` (Web interface)
- **Default credentials**: `guest` / `guest`

## Management Interface

Access the RabbitMQ management web interface at: [http://localhost:15672](http://localhost:15672)

Login with:
- **Username**: `guest`
- **Password**: `guest`

The management interface allows you to:
- Monitor queues and exchanges
- View message rates
- Manage connections and channels
- Create and configure queues
- Send test messages

## Usage Examples

### PHP with AMQP Extension

```bash
dev console
```

In your application:
```php
$connection = new AMQPConnection([
    'host' => 'rabbitmq',
    'port' => 5672,
    'vhost' => '/',
    'login' => 'guest',
    'password' => 'guest'
]);
$connection->connect();
```

### Magento 2 Configuration

In your `env.php`:
```php
'queue' => [
    'amqp' => [
        'host' => 'rabbitmq',
        'port' => '5672',
        'user' => 'guest',
        'password' => 'guest',
        'virtualhost' => '/'
    ]
]
```

## Troubleshooting

Verify RabbitMQ is running:
```bash
dev ps | grep rabbitmq
```

Check RabbitMQ logs:
```bash
dev logs rabbitmq
```
