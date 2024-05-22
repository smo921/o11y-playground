#!/bin/bash

set -e


echo "Vector token path: ${VECTOR_INFLUXDB_TOKEN_PATH}"
while [ ! -f ${VECTOR_INFLUXDB_TOKEN_PATH} ]; do
  echo "No influxdb token found, sleeping 5 seconds"
  sleep 5
done

VECTOR_INFLUXDB_TOKEN=$(cat ${VECTOR_INFLUXDB_TOKEN_PATH})
export VECTOR_INFLUXDB_TOKEN
echo "TOKEN: $VECTOR_INFLUXDB_TOKEN"

cat /templates/datasources/ds_template.yaml > ${GF_PATHS_PROVISIONING}/datasources/ds.yaml
/run.sh
