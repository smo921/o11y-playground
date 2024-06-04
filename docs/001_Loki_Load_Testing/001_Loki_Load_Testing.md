# Loki Load Testing

# Observations

* Vector's `demo_logs` source is only capable of generating ~19k messages / second to Loki
  * This seems to be a limit of how many logs 1 core can generate.
  * Using  multiple `demo_logs` sources, 7 in total, Vector is capable of pushing ~120k+ messages / second to Loki

# Results

The following results were obtained on a 2021 MacBook Pro

* Loki is capable of ingesting ~120k messages / second, at approximately 45 MB/sec.
* The limit is due to CPU overhead of Vector generating random logs.

# Setup Steps:

1. Ensure Docker engine has sufficient disk space.  The load test writes ~45MB/sec to Loki.
  1. Recommend setting the Virtual Disk Limit to 300+ GB if you plan on running the load test for more than 10-15 minutes.
1. Run `make 001_load_test_start` to build and start the load test.
1. Run `make 001_load_test_stop` to stop the load test and revert the Vector configuration to produce logs at a slower rate.
