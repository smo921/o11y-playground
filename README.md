# Logging Playground

Docker based playground for evaluating logging platform components.

The motivation for this repository is to provide a foundation for evaluating, experimenting, and validating observability components.  This
currently consists of Grafana as a front-end web UI, Vector for log collection and manipulation, and Grafana Alloy for metrics collection.
There are three databases configured, including Loki for log aggregation and search, as well as InfluxDB and Prometheus for metrics.  The
[Cloud Native Compute Foundation Observability Landscape](https://landscape.cncf.io/guide#observability-and-analysis--observability) is the
primary source of inspiration on what to evaluate and expose.

The current implementation starts all of the components and wires them together using Docker compose.  This may be extended to launch on
Kubernetes clusters in the future.  Improvements to make components optional is also on the roadmap.

# Getting Started

1.  Install [the Docker engine](https://docs.docker.com/engine/install/)
1.  _Recommended:_ Docker Desktop users should increase the `Virtual Disk Limit` under `Settings -> Resources -> Advanced`.
1.  Clone the GitHub Repo: `git clone git@github.com:smo921/o11y-playground.git`
1.  `cd o11y-playground`
1.  `make start`

The project uses docker compose to manage the components.  This will create a half dozen or so containers for the components.  The following services are exposed locally:

* [Grafana http://localhost:3000/](http://localhost:3000/?orgId=1)
* [Prometheus http://localhost:9090/](http://localhost:9090/graph?)
* [InfluxDB http://localhost:8086/](http://localhost:8086/signin) - username: admin / password: adminPassword
* [Alloy http://localhost:12345/](http://localhost:12345/)

```
user@localhost o11y-playground % make start
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
user@localhost o11y-playground % docker compose ps
NAME                           IMAGE                         COMMAND                  SERVICE      CREATED          STATUS                    PORTS
autoheal                       willfarrell/autoheal:latest   "/docker-entrypoint …"   autoheal     39 seconds ago   Up 38 seconds (healthy)
o11y-playground-alloy-1        grafana/alloy:v1.1.0          "/bin/alloy run --se…"   alloy        39 seconds ago   Up 38 seconds             0.0.0.0:12345->12345/tcp
o11y-playground-grafana-1      grafana/grafana:latest        "sh -euc 'mkdir -p /…"   grafana      39 seconds ago   Up 38 seconds             0.0.0.0:3000->3000/tcp
o11y-playground-influxdb-1     influxdb:2                    "/entrypoint.sh infl…"   influxdb     39 seconds ago   Up 38 seconds (healthy)   0.0.0.0:8086->8086/tcp
o11y-playground-loki-1         grafana/loki:2.9.2            "/usr/bin/loki -conf…"   loki         39 seconds ago   Up 38 seconds             0.0.0.0:3100->3100/tcp
o11y-playground-prometheus-1   prom/prometheus:v2.45.5       "/bin/prometheus --c…"   prometheus   39 seconds ago   Up 38 seconds             0.0.0.0:9090->9090/tcp
o11y-playground-vector-1       o11y-playground-vector        "/custom_entrypoint.…"   vector       39 seconds ago   Up 7 seconds              0.0.0.0:8686->8686/tcp
```


# Development / Contributing

## Build components

`make build` will build any local Dockerfile's in the repo using `docker compose build`.

## Configuration

The local configuration is stored in the subdirectories for each component.

* `alloy/`
* `grafana/`
* `influxdb/`
* `loki/`
* `vector/`

These directores are mounted into the containers by Docker.

### Vector

The configuration watch feature for Vector is enabled, allowing Vector to reload the
configuration when the `vector.yaml` file is updated.

## Shutdown

To reset and perform a basic cleanup of your environment run `make down`.  This will stop and delete the running containers, but preserve the data volumes.

## Cleanup

To completely cleanup your environment run `make clean`.  This will perform the shutdown procedure, and also delete all data volumes associated with the project.
