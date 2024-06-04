# Loki Load Testing

# Observations

* Vector's `demo_logs` source is only capable of generating ~19k messages / second to Loki
* Using  multiple `demo_logs` sources, 7 in total, Vector is capable of pushing ~120k+ messages / second to Loki

# Results

The following results were obtained on a 2021 MacBook Pro

* Loki is capable of ~120k messages / second, approximately XXXX MB/sec <--- get this number from prometheus

# Setup Steps:

1. Backup local `.env` file.
1. Copy `./load_testing.env` to `../.env`
1. Start containers, `docker compose up -d`
