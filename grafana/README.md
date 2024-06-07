# Grafana

Grafana's configuration, provisioning, and dashboards can be found here.  The `bin/entrypoint.sh` script overrides the
default entrypoint, waiting for InfluxDB to provision credentials before starting Grafana.

## Dashboards

Dashboards can be exported from Grafana and saved in the `dashboards/` directory to be provisioned
automatically by Grafana.  Currently there are dashboards for the following:

* System Metrics - `dashboards/system.json`
* Vector Dashboard - `dashboards/vector.json`
* Log Demo Dashboard - `dashboards/demo.json`

## Provisioning

[Grafana can provision configuration](https://grafana.com/docs/grafana/latest/administration/provisioning/) at startup,
including dashboards and data sources.  The `provisioning/` directory holds the YAML files used by
Grafana.  Data sources for Loki, Prometheus, and InfluxDB are created.  Dashboards are imported
from `/var/lib/grafana/dashboards`, which is mounted inside the container from the local
`dashboards/` directory.
