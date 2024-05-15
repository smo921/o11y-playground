# Logging Playground

Docker based playground for evaluating logging platform components.


# Usage

The project uses docker compose to manage the components.  The local configuration is mounted and configuration watch is
enabled for Vector.  This allows for configuration updates to be loaded when the configuration is overwritten.

## Configuration

Vector and Loki configuration are stored in the `vector/` and `loki/` directores respectively.
