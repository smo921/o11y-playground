# Loki Tuning

Notes on scaling and tuning a Loki deployment.

## [Loki Deployment Modes](https://grafana.com/docs/loki/latest/get-started/deployment-modes/)

The Simple Scalable Deployment (SSD) is the recommended deployment pattern.  The SSD separates
components into read, write, and backend categories.  Each is independently scalable, and this
configuration is capable of supporting "up to a few TB of logs per day".

**What is "a few TB of logs per day"?**

One terabyte per twenty-four hour period is a sustained rate of 11.574 MB / second or
41.67 GB / hour.  Every three terabytes per day simplifies the math to ~35 MB / sec or
125 GB / hour.

1 GB / sec == 3600 GB / hour == 10 TB / day.
4 GB / sec == 14400 GB  / hour == 345.6 TB / day


## [Loki Configuration Nuances](https://medium.com/lonto-digital-services-integrator/grafana-loki-configuration-nuances-2e9b94da4ac1)

* Query timeouts
* Set `max_outstanding_requests_per_tenant: 4096` in `query_scheduler` section
* GRPC message sizes: default 4MB
* Chunk encoding: default `gzip`, recommend `snappy`
* Optimize read path: Concurrency settings 
* Optimize write path: adjust rate and burst limits


## Docs / Blogs / References

* https://grafana.com/blog/2023/08/23/how-we-scaled-grafana-cloud-logs-memcached-cluster-to-50tb-and-improved-reliability/
* https://grafana.com/blog/2020/04/21/how-labels-in-loki-can-make-log-queries-faster-and-easier/
* https://grafana.com/blog/2020/08/27/the-concise-guide-to-labels-in-loki/
