setup_repo: setup_influxdb
	mkdir -p log_files

setup_influxdb: clean_influxdb
	docker compose up influxdb

build:
	docker compose build

start:
	docker compose up -d

stop:
	docker compose stop

down:
	docker compose down

clean: down clean_influxdb clean_volumes
	docker compose ps -aq | xargs docker rm

VOLUMES := $(docker volume ls -f "label=com.docker.compose.project=`basename $PWD`")
CURDIR := $(shell basename $(shell pwd))

clean_influxdb:
	docker compose down influxdb
	docker compose ps --services influxdb -q | xargs docker rm
	docker volume rm -f ${CURDIR}_influxdb-data ${CURDIR}_secrets
	rm -f influxdb/influx-configs

clean_volumes:
	docker volume ls -q -f "label=com.docker.compose.project=${CURDIR}" | xargs -I{} docker volume rm {}

env:
	cp example.env .env
