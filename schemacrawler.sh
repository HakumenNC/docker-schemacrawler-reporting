#!/bin/sh

# ========================================================================
# name : schemacrawler.sh
# description : launch the schemacrawler's command : csv
# ========================================================================

docker run \
  --name schemacrawler-additional-lints \
  --rm \
  --volume /${PWD}/exportcsv:/home/schcrwlr \
  --net=host \
  mbarre/schemacrawler-additional-lints //opt/schemacrawler/schemacrawler.sh \
  connect \
    --server=postgresql \
    --host=192.168.12.345 --port=5432 \
    --database=myDatabase --user=myUser --password= \
    --info-level=maximum \
    --log-level=INFO \
    --command=csv \
