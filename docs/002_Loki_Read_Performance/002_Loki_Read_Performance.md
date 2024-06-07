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

### Q1: At what message ingress rate are queries still "reasonably" responsive?  ie, how far can a single instance be pushed when handling real-time read/write activity?

**Setup**

1.  Create a timeseries visualization backed by a log query.  The example query above is a good starting point.
1.  Add a second `random_json` sources to Vector.
1.  Wait five or more minutes to for a window of logging data to be ingested.
1.  Refresh the timeseries graph, and note the request duration / perceived responsiveness.
1.  Continue adding `random_json` sources, waiting, and refreshing.
1.  Stop when the graph is unable to succesfully reload.

### Q2: At what message rate is query performance impacted?  ie, how many messages / second is too much for a single instance to handle read operations?

**Setup**

1.  Create a timeseries visualization backed by a log query.  The example query above is a good starting point.
1.  Run the `001_Loki_Load_Testing` experiment by running `make 001_load_test_start`.
1.  Wait five or more minutes to for a window of logging data to be ingested.
1.  Refresh the timeseries graph, and note the request duration / perceived responsiveness.  In recent testing the current load test generates too many messages for Loki / Grafana to process.
1.  Continue removing one of the `random_json` sources in Vector, waiting five minutes, and trying to refresh the graph.
1.  Continue until the graph loads successfully.
