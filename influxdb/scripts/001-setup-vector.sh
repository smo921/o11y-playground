#!/bin/bash
set -e

influx bucket create \
  --name ${VECTOR_INFLUXDB_METRICS_BUCKET} \
  --description "Vector metrics"

BUCKET_ID=`influx bucket list \
  --name ${VECTOR_INFLUXDB_METRICS_BUCKET} \
  --hide-headers | \
  cut -f 1`

VECTOR_USERNAME="vector"

influx user create \
  --name ${VECTOR_USERNAME} \
  --password "demoPassword"

influx auth create \
  --write-bucket ${BUCKET_ID} \
  --read-bucket ${BUCKET_ID} \
  -u ${VECTOR_USERNAME} \
  -d "Vector-Internal-Metrics"


VECTOR_TOKEN=`influx auth list \
  --user ${VECTOR_USERNAME} | \
  awk -F' ' '$4 == "vector" { print $3 }'`

echo "Auth Token for ${VECTOR_USERNAME}, '${VECTOR_TOKEN}'"
CONFIG_DIR=/etc/influxdb2
mkdir -p $(dirname ${VECTOR_INFLUXDB_TOKEN_PATH})
echo "VECTOR_INFLUXDB_TOKEN=${VECTOR_TOKEN}" > ${VECTOR_INFLUXDB_TOKEN_PATH}
