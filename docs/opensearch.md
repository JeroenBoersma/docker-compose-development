# OpenSearch

OpenSearch is an open-source search and analytics engine forked from Elasticsearch. It's compatible with Elasticsearch APIs and can be used as an alternative.

## Setup

Enable OpenSearch during the initial setup:
```bash
dev setup
```

If you've already set up your environment, enable OpenSearch by creating a configuration marker:
```bash
mkdir -p conf/opensearch
dev rebuild
```

## Configuration

OpenSearch is available at:
- **Host**: `opensearch`
- **Port**: `9200`
- **Security**: Disabled by default (development environment)

## OpenSearch vs Elasticsearch

OpenSearch is API-compatible with Elasticsearch and can be used as a drop-in replacement. Key differences:
- Open-source license (Apache 2.0)
- Active community development
- Compatible with existing Elasticsearch clients
- Security plugins available

## Usage

### Health Check

Verify OpenSearch is running:
```bash
dev console curl -X GET "opensearch:9200/_cluster/health?pretty"
```

### Basic Operations

Create an index:
```bash
dev console curl -X PUT "opensearch:9200/my-index"
```

Index a document:
```bash
dev console curl -X POST "opensearch:9200/my-index/_doc" -H 'Content-Type: application/json' -d '{"field": "value"}'
```

Search:
```bash
dev console curl -X GET "opensearch:9200/my-index/_search?q=field:value"
```

## Application Configuration

### PHP Applications

Use the hostname `opensearch` and port `9200`:
```php
$client = new OpenSearch\Client([
    'hosts' => ['opensearch:9200']
]);
```

### Magento 2

In your `env.php`:
```php
'system' => [
    'default' => [
        'catalog' => [
            'search' => [
                'engine' => 'opensearch',
                'opensearch_server_hostname' => 'opensearch',
                'opensearch_server_port' => '9200'
            ]
        ]
    ]
]
```

## OpenSearch Dashboard

For a web-based interface, see [opensearch-dashboard.md](opensearch-dashboard.md).

## Troubleshooting

Check if OpenSearch is running:
```bash
dev ps | grep opensearch
```

View OpenSearch logs:
```bash
dev logs opensearch
```

If you need both OpenSearch and Elasticsearch, you cannot run them simultaneously on the same port. Choose one for your project.
