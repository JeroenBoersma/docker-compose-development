# MongoDB

MongoDB is a NoSQL document database that can be enabled in your development environment. It comes with mongo-express, a web-based MongoDB admin interface.

## Setup

Enable MongoDB during the initial setup by running:
```bash
dev setup
```

If you've already set up your environment, you can enable MongoDB by creating a configuration marker:
```bash
mkdir -p conf/mongo
dev rebuild
```

## Configuration

MongoDB runs with default credentials:
- **Username**: `root`
- **Password**: `example`

To connect to MongoDB from your applications, use:
- **Host**: `mongo`
- **Port**: `27017`
- **Connection string**: `mongodb://root:example@mongo:27017`

## mongo-express Web Interface

MongoDB includes mongo-express, a web-based admin interface for managing your databases.

Access it at: [http://localhost:8081](http://localhost:8081)

## Usage Examples

### Connect from PHP

```bash
dev console
```

Then in your application:
```php
$client = new MongoDB\Client("mongodb://root:example@mongo:27017");
$database = $client->mydatabase;
$collection = $database->mycollection;
```

### Using MongoDB Shell

Access the MongoDB shell:
```bash
dev exec mongo mongosh -u root -p example
```

## Troubleshooting

If MongoDB isn't starting, make sure the configuration marker exists:
```bash
ls conf/mongo
```

If the directory doesn't exist, create it and rebuild:
```bash
mkdir -p conf/mongo
dev down
dev up
```
