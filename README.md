# docker-schemacrawler-reporting
Use schemacrawler on docker environment
# schemacrawler - Reporting and docker Integration

## Description

Use schemacrawler on docker environment :

* Launch schemacrawler with additional plugins
* ElasticSearch/Kibana for the rescue and build dashboards
* Logstach agent daemon to watch newly exported files

## Prerequisites

* docker : <https://www.docker.com/get-started>
* docker-compose : <https://docs.docker.com/compose/install/>

## How to use

### Fantastic Elastic

* Deploy the Elastic World

```sh
docker-compose --project-name schemacrawler -f elasticsearch.yml up -d
```

* ...And that's all !

* After several minutes, you can testing if everything it's OK with :
  * <http://localhost:9200> (ElasticSearch container)
  * <http://localhost:5601> (Kibana container)

In your favorite internet browser.

### Logstash is watching you

* Invoke and unleash the Logstash daemon

```sh
docker run --rm -it -v %cd%/logstash.pipeline/:/usr/share/logstash/pipeline/ -v %cd%/logstash.conf/:/usr/share/logstash/config/ -v %cd%/exportcsv/:/usr/share/logstash/inputs/ docker.elastic.co/logstash/logstash:7.9.2
```

### Let's analyze the database

#### Add plugins (optionnal)

Copy plugins `.jar` in `plugins` folder eventually

#### Run schemaCrawler

* Build schemaCrawler docker image

```sh
docker build --tag schemacrawler-enhanced .
```

* Run the container

```sh
docker run --rm -v %cd%/exportcsv:/home/schcrwlr --name schemacrawler-enhanced schemacrawler-enhanced /opt/schemacrawler/schemacrawler.sh connect --server=postgresql --host=192.168.67.181 --port=5432 --database=optisee --user=optisee --command=csv
```
