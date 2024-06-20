# 002 - Loki Read Performance

Log graphing during and after write load testing resulted in query errors.  The query performed involves two parsing operations, a field
extraction, a rate calculation, and a roll-up task.  This is performed in real-time on the results, which is helpful in testing query
performance.

```
sum by(status) (rate({source=\"random_json\"} | json | line_format `{{.message}}` | json | keep status | status =~ `[245]..` [1m]))
```

A single Loki container handling read and write tasks is unable to keep up with 120k incoming messages / sec, while simultaneously processing real-time query requests.

## Questions

1.  At what message ingress rate are queries still "reasonably" responsive?  ie, how far can a single instance be pushed when handling real-time read/write activity?
1.  At what message rate is query performance impacted?  ie, how many messages / second is too much for a single instance to handle read operations?
1.  Simple query, limited to 1k, 10k, 100k, 500k, 1M events, while under ingest load.

### Q1: At what message ingress rate are queries still "reasonably" responsive?  ie, how far can a single instance be pushed when handling real-time read/write activity?

**Setup**

1.  Create a timeseries visualization backed by a log query.  The example query above is a good starting point.
1.  Add a second `random_json` sources to Vector.
1.  Wait five or more minutes to for a window of logging data to be ingested.
1.  Refresh the timeseries graph, and note the request duration / perceived responsiveness.
1.  Continue adding `random_json` sources, waiting, and refreshing.
1.  Stop when the graph is unable to succesfully reload.

**Results**

The results are summarized in more detail below.  In short, a single instance is capable of ingesting roughly 20k events/second, and
serving queries of ~6-7M events simultaneously.  This appears to be limited by the single thread performance of Loki, which appears to
be CPU bound.  The result is the Loki query context timing out.  Indicating that this can be adjusted to allow for queries over larger
data sets.

### Q2: At what message rate is query performance impacted?  ie, how many messages / second is too much for a single instance to handle read operations?

**Setup**

1.  Create a timeseries visualization backed by a log query.  The example query above is a good starting point.
1.  Run the `001_Loki_Load_Testing` experiment by running `make 001_load_test_start`.
1.  Wait five or more minutes to for a window of logging data to be ingested.
1.  Refresh the timeseries graph, and note the request duration / perceived responsiveness.  In recent testing the current load test generates too many messages for Loki / Grafana to process.
1.  Continue removing one of the `random_json` sources in Vector, waiting five minutes, and trying to refresh the graph.
1.  Continue until the graph loads successfully.

**Results**

A single Loki instance consists of multiple components, running as threads/processes.  The two busiest in our test are the ingest and 
query components.  While ingesting at a rate of 20k events/second a single Loki instance was able to return complex query results
across 6-7M logs before the timeout was reached.  With no ingress, a single instance with a basic configuration is capable of
processing roughly 8.6M logs in a single query.  The only tuning performed was setting the following configuration parameter:

```
query_scheduler:
  max_outstanding_requests_per_tenant: 4096
```

Vector configuration consisted of a single `demo_logs` source emitting `json` encoded logs with `interval: 0.0` (as fast as possible).  This
amounts to roughly 20k events/second, 593MB of Raw Data transmitted by Vector, and 3.21GB of Event data transmitted.  This is likely the
uncompressed vs wire size of the events, as witnessed by Vector.

Loki runtime metrics have not been examined at this point.

### Q2: Simple query, limited to 1k, 10k, 100k, 500k, 1M events, while under ingest load.

Rather than perform complex queries used in the previous tests, how does Loki perform when under ingest load and performing simple queries when limiting search results.
