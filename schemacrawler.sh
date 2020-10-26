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
    --server=postgres \
    --host=localhost \
    --user=user \
    --password=password \
    --database=db \
    --info-level=maximum \
    --log-level=INFO \
    --command=csv \
