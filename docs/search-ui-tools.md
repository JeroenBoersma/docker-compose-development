# Search UI Tools

Several web-based user interfaces are available for managing and monitoring Elasticsearch and OpenSearch clusters.

## ElasticVue

ElasticVue is a modern, feature-rich web UI for Elasticsearch and OpenSearch with a clean interface and powerful features.

### Setup

Enable ElasticVue during setup or manually:
```bash
mkdir -p conf/elasticvue
dev rebuild
```

### Access

ElasticVue is available at: [http://localhost:8080](http://localhost:8080)

### Connecting to Elasticsearch/OpenSearch

When you first access ElasticVue, add your cluster:
- **URI**: `http://elasticsearch:9200` (for Elasticsearch) or `http://opensearch:9200` (for OpenSearch)
- **Name**: Any name you prefer
- **Username/Password**: Leave empty (no auth in development)

### Features

ElasticVue provides:
- **Cluster Overview**: Health, nodes, shards
- **Index Management**: Create, delete, configure indices
- **Document Browser**: View and edit documents
- **Query Interface**: Run search queries with syntax highlighting
- **Snapshots**: Manage backups
- **Index Templates**: Configure templates
- **REST Client**: Execute arbitrary REST API calls

### ElasticVue CORS Variants

For older Elasticsearch versions that don't support CORS properly, CORS-enabled variants are available:

**For Elasticsearch 6.x:**
```bash
mkdir -p conf/elasticvue-cors
dev rebuild
```

**For Elasticsearch 7.x:**
```bash
mkdir -p conf/elasticvue-cors7
dev rebuild
```

These run a proxy that adds CORS headers.

## Elasticsearch HQ

Elasticsearch HQ is a lighter-weight monitoring tool focused on cluster health and management.

### Setup

Enable Elasticsearch HQ:
```bash
mkdir -p conf/elasticsearchhq
dev rebuild
```

### Access

Elasticsearch HQ is available at: [http://localhost:5000](http://localhost:5000)

### Features

Elasticsearch HQ provides:
- **Cluster Health Monitoring**: Real-time cluster status
- **Node Statistics**: CPU, memory, disk usage per node
- **Index Information**: Index stats and settings
- **Query Metrics**: Query performance data
- **Shard Allocation**: Visual shard distribution

Elasticsearch HQ is read-only and focuses on monitoring rather than management.

## Choosing a UI Tool

**Use ElasticVue if you:**
- Need full cluster management capabilities
- Want to edit documents and indices
- Prefer a modern, feature-rich interface
- Work with both Elasticsearch and OpenSearch

**Use Elasticsearch HQ if you:**
- Only need monitoring (not management)
- Prefer a simpler, lightweight tool
- Focus on cluster health and performance

## OpenSearch Dashboard

For OpenSearch specifically, OpenSearch Dashboard (similar to Kibana) is available. See [opensearch-dashboard.md](opensearch-dashboard.md).

OpenSearch Dashboard is more comprehensive than ElasticVue or Elasticsearch HQ, offering:
- Visualizations and dashboards
- Dev Tools console
- Full index management
- Advanced analytics

## Troubleshooting

### Cannot Connect to Cluster

Verify Elasticsearch/OpenSearch is running:
```bash
dev ps | grep -E 'elasticsearch|opensearch'
```

Test connectivity from within the network:
```bash
dev console curl -X GET "elasticsearch:9200"
```

### CORS Errors

If you see CORS errors with ElasticVue, use the CORS-enabled variant:
- Elasticsearch 6.x: Use `elasticvue-cors`
- Elasticsearch 7.x: Use `elasticvue-cors7`

### UI Tool Not Starting

Check logs:
```bash
dev logs elasticvue
# or
dev logs elasticsearchhq
```

Ensure the configuration marker exists:
```bash
ls conf/elasticvue
ls conf/elasticsearchhq
```
