# ElasticSearch

Make sure that you enable ElasticSearch during the setup of the docker containers. If you already setup your 
environment, you can still enable it by rebuilding your containers using `dev rebuild` and `dev setup`.

## Location

ElasticSearch is available via `elasticsearch:9200` and can be used in any application you want without any HTTP
authentication.

### Health Check

To make sure the ElasticSearch environment is running as expected, run this command in your terminal:
```bash
curl -X GET "elasticsearch:9200/_cluster/health?pretty"
```

## Smile ElasticSuite

When you're working with Magento 2 and you use [Smile ElasticSuite](https://github.com/Smile-SA/elasticsuite), you need to 
install two additional plugins for ElasticSearch that aren't installed by default. To do that make sure you follow the
next steps:

Create a new file in `~/development/workspace/build/dist/elasticsearch/Dockerfile`
Copy this content to the file:
```bash
FROM elasticsearch:6.5.4

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-phonetic && \
    /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-icu
```

Make sure that the version mentioned after `FROM` is the same as the version of ElasticSearch that you installed.

Now make sure you rerun `dev down` and `dev rebuild` to install these plugins. You're now ready to use Smile 
ElasticSuite.
