# OpenSearch Dashboard

OpenSearch Dashboard is a web-based visualization tool for OpenSearch, similar to Kibana for Elasticsearch. It provides an interface to explore, visualize, and analyze your data.

## Setup

First, make sure OpenSearch is enabled (see [opensearch.md](opensearch.md)). Then enable OpenSearch Dashboard:

```bash
dev setup
```

If you've already set up your environment:
```bash
mkdir -p conf/opensearch-dashboard
dev rebuild
```

## Access

OpenSearch Dashboard is available at: [http://localhost:5601](http://localhost:5601)

## Features

OpenSearch Dashboard provides:
- **Discover**: Explore your data with powerful search
- **Visualize**: Create charts, graphs, and maps
- **Dashboard**: Combine visualizations into dashboards
- **Dev Tools**: Execute queries and API calls
- **Management**: Configure indices, mappings, and settings

## Using Dev Tools

The Dev Tools console is useful for testing queries:

1. Navigate to [http://localhost:5601](http://localhost:5601)
2. Click "Dev Tools" in the left menu
3. Execute queries directly:

```
GET /_cluster/health

GET /my-index/_search
{
  "query": {
    "match_all": {}
  }
}
```

## Troubleshooting

Ensure both OpenSearch and OpenSearch Dashboard are running:
```bash
dev ps | grep opensearch
```

Check OpenSearch Dashboard logs:
```bash
dev logs opensearch-dashboard
```

If the dashboard shows "OpenSearch Dashboards server is not ready yet":
- Wait a moment for OpenSearch to fully start
- Verify OpenSearch is accessible: `dev console curl opensearch:9200`
