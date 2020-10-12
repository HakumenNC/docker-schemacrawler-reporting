# docker-schemacrawler-reporting

* [Description](#description)
* [Prerequisites](#prerequisites)
* [How to use](#how-to-use)
  * [Fantastic Elastic](#fantastic-elastic)
  * [Logstash is watching you](#logstash-is-watching-you)
  * [Let's analyze the database](#lets-analyze-the-database)
* [Usefuls links](#usefuls-links)

## Description

Use [schemacrawler](https://www.schemacrawler.com) on docker environment :

* Deploy the entire [ELK](https://www.elastic.co/what-is/elk-stack) `7.9.2` stack
  * [**E**lasticSearch](https://www.elastic.co/what-is/elasticsearch) for data storage
  * [**L**ogstash](https://www.elastic.co/logstash) agent daemon for process newly exported files
  * [**K**ibana](https://www.elastic.co/kibana) for display beautifuls dashboards !
* Launch the schemacrawler's command : [csv](https://github.com/adriens/schemacrawler-additional-command-lints-as-csv)

## Prerequisites

* A database
* What is [SchemaCrawler](https://www.schemacrawler.com/faq.html#whats-schemacrawler) ?
* What is [ELK](https://www.elastic.co/what-is/elk-stack) ?
* docker : <https://www.docker.com/get-started>
  * docker-compose : <https://docs.docker.com/compose/install/>

## How to use

### Fantastic Elastic

* Deploy the Elastic World (in case if we want the all stack on local environnement else use the `ek.yml` file, without Logstash so)

```sh
docker-compose --project-name schemacrawler-elk -f elk.yml up -d
```

* ...And that's all !

```sh
$ docker ps
CONTAINER ID        IMAGE                                                 COMMAND                  CREATED             STATUS              PORTS                              NAMES
130787ecd783        docker.elastic.co/logstash/logstash:7.9.2             "/usr/local/bin/dock…"   About an hour ago   Up 41 minutes       5044/tcp, 9600/tcp                 logstash
9fabc346ce9e        postgres:11.5                                         "docker-entrypoint.s…"   3 hours ago         Up 35 minutes       0.0.0.0:5432->5432/tcp             optisee_optisee-postgresql_1
d426d2f30ed7        docker.elastic.co/kibana/kibana:7.9.2                 "/usr/local/bin/dumb…"   2 days ago          Up 41 minutes       0.0.0.0:5601->5601/tcp             kibana
9b7106e5b1dd        docker.elastic.co/elasticsearch/elasticsearch:7.9.2   "/tini -- /usr/local…"   3 days ago          Up 41 minutes       0.0.0.0:9200->9200/tcp, 9300/tcp   elasticsearch
```

* After several minutes, we can testing if everything it's OK with :
  * <http://localhost:9200> (elasticsearch)
  * <http://localhost:5601> (kibana)

In your favorite internet browser.

### Logstash is watching you

(Only in case of Logstash in '**s**tand-**a**lone' mode)

* Update connection informations on config files under the `logstash-sa` folder
  
***config/logstash.yml* :**

```yml
monitoring.elasticsearch.hosts: <elasticSearch url>
```

***pipeline/logstash-\*.conf*** modify for each file : (Based from [schemacrawler-additional-command-lints-as-csv](<https://github.com/adriens/schemacrawler-additional-command-lints-as-csv>))

```conf
...
output {
   elasticsearch {
     hosts => "<elasticSearch url>"
     index => "schemacrawler-tables-stats"
   }
...
```

* Invoke and unleash the Logstash daemon

```sh
sh logstash-sa.sh
```

### Let's analyze the database

**We use the folder `exportcsv` for export/inject the .csv files**

#### Run schemaCrawler

* Edit the `schemacrawler.sh` file for fill the connection informations of your database

* Run it !

```sh
sh schemacrawler.sh
```

The docker image [mbarre/schemacrawler-additional-lints](https://hub.docker.com/r/mbarre/schemacrawler-additional-lints) is used to run schemacrawler everywhere !

## Usefuls links

* <https://www.elastic.co/what-is/elk-stack>
* <https://github.com/mbarre/schemacrawler-additional-lints>
* <https://github.com/adriens/schemacrawler-additional-command-lints-as-csv>
* <https://www.schemacrawler.com/>
  * <https://github.com/schemacrawler/SchemaCrawler>
