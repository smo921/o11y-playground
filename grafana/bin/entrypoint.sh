#!/bin/bash

set -e


# Read InfluxDB API Token from $VECTOR_INFLUXDB_TOKEN_PATH
echo "Vector token path: ${VECTOR_INFLUXDB_TOKEN_PATH}"
while [ ! -f ${VECTOR_INFLUXDB_TOKEN_PATH} ]; do
  echo "No influxdb token found, sleeping 5 seconds"
  sleep 5
done

VECTOR_INFLUXDB_TOKEN=$(cat ${VECTOR_INFLUXDB_TOKEN_PATH})
export VECTOR_INFLUXDB_TOKEN
echo "TOKEN: $VECTOR_INFLUXDB_TOKEN"

/run.sh
