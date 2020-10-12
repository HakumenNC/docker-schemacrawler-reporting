#!/bin/sh

# ========================================================================
# name : logstash-sa.sh
# description : launch a logstash container
# ========================================================================

docker run \
  --name logstash-sa \
  --rm -it \
  --volume /${PWD}/logstash-sa/pipeline/:/usr/share/logstash/pipeline/ \
  --volume /${PWD}/logstash-sa/config/:/usr/share/logstash/config/ \
  --volume /${PWD}/exportcsv/:/usr/share/logstash/inputs/ \
  docker.elastic.co/logstash/logstash:7.9.2
