backup: sws
	docker compose exec influxdb influx export all --filter kind=Dashboard --filter labelName=001 > docs/001_Loki_Load_Testing/influxdb-dashboards/001-Load-Testing.yaml

restore: sws
	docker compose exec influxdb influx apply -o test_org -u http://sws/001_Loki_Load_Testing/influxdb-dashboards/001-Load-Testing.yaml 

sws:
	docker compose up sws -d

PROJECTDIR := $(shell pwd)

run:
	mv ${CURDIR}/vector/vector.yaml ${CURDIR}/vector/vector.yaml.bak
	cp ${CURDIR}/docs/001_Loki_Load_Testing/vector/config.yaml ${CURDIR}/vector/vector.yaml

stop:
	mv ${CURDIR}/vector/vector.yaml.bak ${CURDIR}/vector/vector.yaml
