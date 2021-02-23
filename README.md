# docker-schemacrawler-reporting

[![Schemacrawler](https://github.com/HakumenNC/logo-gallery/raw/main/img/schemacrawler/schemacrawler.png)](https://www.schemacrawler.com "Schemacrawler")
[![docker](https://github.com/HakumenNC/logo-gallery/raw/main/img/docker/docker.png)](https://www.docker.com "Docker")
[![dockercompose](https://github.com/HakumenNC/logo-gallery/raw/main/img/docker-compose/docker-compose.png)](https://docs.docker.com/compose "Docker compose")
[![Vagrant](https://github.com/HakumenNC/logo-gallery/raw/main/img/devops/vagrant/vagrant.png)](https://www.vagrantup.com/ "Vagrant")
[![elk](https://github.com/HakumenNC/logo-gallery/raw/main/img/elk/elk.png)](https://www.elastic.co "ELK")

* [Demo](#bar_chart-demo)
* [Description](#speech_balloon-description)
* [Prerequisites](#books-prerequisites)
  * [Installation](#installation)
  * [Database sample](#database-sample)
  * [Extra documentation](#extra-documentation)
* [How to use](#rocket-how-to-use)
  * [Get the project](#get-the-project)
  * [Fantastic Elastic](#fantastic-elastic)
  * [Logstash is watching you](#logstash-is-watching-you)
  * [Let's analyze the database](#lets-analyze-the-database)
    * [Run schemaCrawler](#run-schemaCrawler)
  * [Jump in Kibana](#jump-in-Kibana)
    * [Create Index pattern](#create-index-pattern)
    * [Beautifuls Dashboards incoming](#beautifuls-dashboards-incoming)
* [A ready-to-use environment with Vagrant](#computer-a-ready-to-use-environment-with-vagrant)
  * [Prerequisites](#Prerequisites)
  * [Go!](#go-)
* [Troubleshooting](#gun-Troubleshooting)
  * [No such host on pulling docker images](#no-such-host-on-pulling-docker-images)
* [Further with Schemacrawler](#point_right-further-with-schemacrawler)
* [Usefuls links](#link-usefuls-links)

## :bar_chart: Demo

Some [Kibana Dashboards visuals](https://hakumennc.github.io/docker-schemacrawler-reporting/) produced on top of this project.

<img src="img/dashboard-lints.PNG" alt="lints" title="lints" height="100" /> <img src="img/dashboard-rgpd.PNG" alt="lints" title="RGPD" height="100" /> <img src="img/dashboard.png" alt="dashboard" title="dashboard" height="100" />

## :speech_balloon: Description

* Use [schemacrawler](https://www.schemacrawler.com) on docker :whale: environment.
* Launch the schemacrawler's command [csv](https://github.com/adriens/schemacrawler-additional-command-lints-as-csv) trough `docker run`
* Use and Deploy the entire [ELK](https://www.elastic.co/what-is/elk-stack) `7.9.2` stack to consume the exported csv
  * [ElasticSearch](https://www.elastic.co/what-is/elasticsearch) for data storage
  * [Logstash](https://www.elastic.co/logstash) agent daemon for process newly exported files
  * [Kibana](https://www.elastic.co/kibana) for display beautifuls dashboards !

## :books: Prerequisites

### Installation

* Download [git](https://git-scm.com/downloads)
* Get started with [docker](https://www.docker.com/get-started)
* Install [docker-compose](https://docs.docker.com/compose/install/)

```console
$ git --version
git version 2.23.0.windows.1
```

```console
$ docker -v
Docker version 18.09.6, build c89750f8
```

```console
$ docker-compose -v
docker-compose version 1.27.4, build 40524192
```

### Database sample

:bulb: No database on hand? Don't panic, let's go [here](sampledb)

### Extra documentation

* What is [SchemaCrawler](https://www.schemacrawler.com/faq.html#whats-schemacrawler) ?
* What is [ELK](https://www.elastic.co/what-is/elk-stack) ?

## :rocket: How to use

### Get the project

```bash
git clone https://github.com/HakumenNC/docker-schemacrawler-reporting.git
```

```bash
cd docker-schemacrawler-reporting
```

### Fantastic Elastic

Deploy the Elastic World *(in case if we want the all stack on local environnement else use the `ek.yml` file, without Logstash so)*

```sh
docker-compose --project-name schemacrawler-elk -f elk.yml up -d
```

...And that's all :clap: !

```console
$ docker ps
CONTAINER ID        IMAGE                                                 COMMAND                  CREATED             STATUS              PORTS                              NAMES
130787ecd783        docker.elastic.co/logstash/logstash:7.9.2             "/usr/local/bin/dock…"   About an hour ago   Up 41 minutes       5044/tcp, 9600/tcp                 logstash
9fabc346ce9e        postgres:11.5                                         "docker-entrypoint.s…"   3 hours ago         Up 35 minutes       0.0.0.0:5432->5432/tcp             optisee_optisee-postgresql_1
d426d2f30ed7        docker.elastic.co/kibana/kibana:7.9.2                 "/usr/local/bin/dumb…"   2 days ago          Up 41 minutes       0.0.0.0:5601->5601/tcp             kibana
9b7106e5b1dd        docker.elastic.co/elasticsearch/elasticsearch:7.9.2   "/tini -- /usr/local…"   3 days ago          Up 41 minutes       0.0.0.0:9200->9200/tcp, 9300/tcp   elasticsearch
```

After several minutes, we can testing if everything it's OK with :

* <http://localhost:9200> (elasticsearch)
* <http://localhost:5601> (kibana)

### Logstash is watching you

If you run logstash separately, take a look for the configuration [here](logstash.md)

News calculateds fields (in [ruby](https://www.ruby-lang.org/) :gem:) are added on logstash step :

| field | pipeline | description |
| - | - | - |
| `sclint-isRGPDColumn` | [logstash-columns.conf](logstash/pipeline/logstash-columns.conf) | Is `true` if the column's remark (based on field `sclint-column-remarks`) contains "RGPD" string else `false` |
| `sclint-linterIdClassName` | [logstash-lints.conf](logstash/pipeline/logstash-lints.conf) | Return the className of field `sclint-linterId` |
| `sclint-linterIdPackageName` | [logstash-lints.conf](logstash/pipeline/logstash-lints.conf) | Return the package's path of field `sclint-linterId` |

:bulb: Feel free to create PR or issues for any new ideas of calculateds fields !

### Let's analyze the database

**We use the folder `exportcsv` :file_folder: for export/inject the .csv files**

#### Run schemaCrawler

* Edit the `schemacrawler.sh` file for fill the connection informations of your database

* Run it :rocket: !

```sh
sh schemacrawler.sh
```

The docker image [mbarre/schemacrawler-additional-lints](https://hub.docker.com/r/mbarre/schemacrawler-additional-lints) is used to run schemacrawler everywhere or almost !

### Jump in Kibana

#### Create Index pattern

* Go to <http://localhost:5601>

* Reach the `Stack Management` via the side left menu

* In `Index Patterns` page, click on `Create index pattern` button

* Type `schemacrawler-*` as an index pattern name and click on `Next step`

* Select `@timestamp` as Time field

* Finally, click on `Create index pattern`

You are now ready to see the data imported on the `Discover` page (In the side menu : Kibana/Discover)

#### Beautifuls Dashboards incoming

It's creativity time! Kibana provide [Dashboard](https://www.elastic.co/guide/en/kibana/current/dashboard-create-new-dashboard.html) and [Canvas](https://www.elastic.co/fr/what-is/kibana-canvas) for visualisations.
See some [examples](https://hakumennc.github.io/docker-schemacrawler-reporting/)

## :computer: A ready-to-use environment with Vagrant

Don't want to execute docker commands... but try all the stack quickly... This is the solution.

Following tools are installed :

* docker
* docker-compose
* portainer (localhost:9000)
* elasticsearch (localhost:9200)
* kibana (localhost:5601)
* logstash
* schemacrawler
* postgresql and a demo database

### Prerequisites

* [Vagrant](https://www.vagrantup.com/downloads)

### Go !

* vagrant up
* vagrant ssh
* sh schemacrawler.sh
* see results in kibana !

## :gun: Troubleshooting

... And avoid tears of blood

### No such host on pulling docker images

Got this issue (personnally experimented on Windows 10 at home... And randomly hapenned)? Please see <https://docs.docker.com/docker-for-windows/troubleshoot/#networking-issues>

```bash
Unable to find image 'hello-world:latest' locally
Pulling repository docker.io/library/hello-world
C:\Program Files\Docker\Docker\Resources\bin\docker.exe: Error while pulling image: Get https://index.docker.io/v1/repositories/library/hello-world/images: dial tcp: lookup index.docker.io on 10.0.75.1:53: no such host.
See 'C:\Program Files\Docker\Docker\Resources\bin\docker.exe run --help'.
```

And if it is not enough, set as DNS Server `8.8.8.8` on your Windows' network card directly...

## :point_right: Further with Schemacrawler

* [Schemacrawler Lints with Github Actions on Dev.to](https://dev.to/sualeh/lint-your-database-schema-with-github-actions-workflows-57cg)
* [Generate Database Diagrams With GitHub Actions Workflows](https://dev.to/sualeh/generate-database-diagrams-with-github-actions-workflows-4l96)
* [SchemaCrawler tutorials on Katacoda.](https://www.katacoda.com/schemacrawler)

## :link: Usefuls links

* [Dashboard demo](https://hakumennc.github.io/docker-schemacrawler-reporting/)
* [What is ELK Stack ?](https://www.elastic.co/what-is/elk-stack)
* [mbarre/schemacrawler-additional-lints](https://github.com/mbarre/schemacrawler-additional-lints)
* [adriens/schemacrawler-additional-command-lints-as-csv](https://github.com/adriens/schemacrawler-additional-command-lints-as-csv)
* [SchemaCrawler - Free database schema discovery and comprehension tool](https://www.schemacrawler.com/)
  * [schemacrawler/SchemaCrawler](https://github.com/schemacrawler/SchemaCrawler)
* [Introduction to Vagrant](https://www.vagrantup.com/intro/index)

## Resources

* Some "ready-to-use" dashboards example [dashboards.ndjson](dashboards.ndjson)
