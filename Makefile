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

clean: down clean_influxdb
	docker compose down
	docker compose ps -aq | xargs docker rm

clean_influxdb:
	docker compose down influxdb
	docker compose ps --services influxdb -q | xargs docker rm
	docker volume rm -f loki_playground_influxdb-data loki_playground_secrets
	rm -f influxdb/influx-configs

env:
	cp example.env .env
