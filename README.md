# Logging Playground

Docker based playground for evaluating logging platform components.

# Usage

The project uses docker compose to manage the components.  To quickly get started run `make start`.  This will create a half dozen or so containers for the components.  The following services are exposed locally:

* [Grafana http://localhost:3000/](http://localhost:3000/?orgId=1)
* [Prometheus http://localhost:9090/](http://localhost:9090/graph?)
* [InfluxDB http://localhost:8086/](http://localhost:8086/signin) - username: admin / password: adminPassword
* [Alloy http://localhost:12345/](http://localhost:12345/)

```
soberther@localhost o11y-playground % make start
docker compose up -d
[+] Running 7/11
 ⠸ Network o11y-playground_loki            Created         31.3s
 ⠸ Network o11y-playground_default         Created         31.3s
 ⠸ Volume "o11y-playground_influxdb-data"  Created         31.2s
 ⠸ Volume "o11y-playground_secrets"        Created         31.2s
 ✔ Container o11y-playground-alloy-1       Started         0.6s
 ✔ Container o11y-playground-grafana-1     Started         0.6s
 ✔ Container o11y-playground-prometheus-1  Started         0.7s
 ✔ Container autoheal                      Started         0.4s
 ✔ Container o11y-playground-influxdb-1    Healthy         31.1s
 ✔ Container o11y-playground-loki-1        Started         0.6s
 ✔ Container o11y-playground-vector-1      Started         31.2s
soberther@localhost o11y-playground % docker compose ps
NAME                           IMAGE                         COMMAND                  SERVICE      CREATED          STATUS                    PORTS
autoheal                       willfarrell/autoheal:latest   "/docker-entrypoint …"   autoheal     39 seconds ago   Up 38 seconds (healthy)
o11y-playground-alloy-1        grafana/alloy:v1.1.0          "/bin/alloy run --se…"   alloy        39 seconds ago   Up 38 seconds             0.0.0.0:12345->12345/tcp
o11y-playground-grafana-1      grafana/grafana:latest        "sh -euc 'mkdir -p /…"   grafana      39 seconds ago   Up 38 seconds             0.0.0.0:3000->3000/tcp
o11y-playground-influxdb-1     influxdb:2                    "/entrypoint.sh infl…"   influxdb     39 seconds ago   Up 38 seconds (healthy)   0.0.0.0:8086->8086/tcp
o11y-playground-loki-1         grafana/loki:2.9.2            "/usr/bin/loki -conf…"   loki         39 seconds ago   Up 38 seconds             0.0.0.0:3100->3100/tcp
o11y-playground-prometheus-1   prom/prometheus:v2.45.5       "/bin/prometheus --c…"   prometheus   39 seconds ago   Up 38 seconds             0.0.0.0:9090->9090/tcp
o11y-playground-vector-1       o11y-playground-vector        "/custom_entrypoint.…"   vector       39 seconds ago   Up 7 seconds              0.0.0.0:8686->8686/tcp
```

## Build componenets

`make build` will build any local Dockerfile's in the repo using `docker compose build`.

## Configuration

The local configuration is stored in the subdirectories for each component.

* `alloy/`
* `influxdb/`
* `loki/`
* `vector/`

These directores are mounted into the containers by Docker.

### Vector

The configuration watch feature for Vector is enabled, allowing Vector to reload the
configuration when the `vctor.yaml` file is updated.

## Shutdown

To reset and perform a basic cleanup of your environment run `make down`.  This will stop and delete the running containers, but preserve the data volumes.

## Cleanup

To completely cleanup your environment run `make clean`.  This will perform the shutdown procedure, and also delete all data volumes associated with the project.
