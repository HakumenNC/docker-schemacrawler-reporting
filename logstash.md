# Run Logstash separately

:stop_sign: Only in case of Logstash in '**s**tand-**a**lone' mode

* Update connection informations on config files under the `logstash-sa` folder
  
**:page_with_curl: *config/logstash.yml* :**

```yml
monitoring.elasticsearch.hosts: <elasticSearch url>
```

**:page_with_curl: *pipeline/logstash-\*.conf*** modify for each file : (Based from [schemacrawler-additional-command-lints-as-csv](<https://github.com/adriens/schemacrawler-additional-command-lints-as-csv>))

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