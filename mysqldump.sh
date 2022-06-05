#!/bin/bash

set -eu
eval `cat ./.env | grep -v ^# | grep -v -e '^[[:space:]]*$' |sed -e 's/\s*=\s*/=/g'`
docker-compose exec db mysqldump ${MYSQL_DATABASE} | gzip > dump/`date +'%Y%m%d'`_${MYSQL_DATABASE}.dump.gz