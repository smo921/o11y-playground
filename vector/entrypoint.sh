#!/bin/bash
set -e

echo "Entry point started"

while [ ! -f ${VECTOR_INFLUXDB_TOKEN_PATH} ]; do
  echo "No influxdb token found, sleeping 5 seconds"
  sleep 5
done

VECTOR_INFLUXDB_TOKEN=$(cat ${VECTOR_INFLUXDB_TOKEN_PATH})
export VECTOR_INFLUXDB_TOKEN

exec /usr/bin/vector --watch-config
