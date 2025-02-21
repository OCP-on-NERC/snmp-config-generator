# NERC SNMP Exporter Configuration

This repository contains:

1. A `generator.yml` for input into the [snmp-exporter] config generator.
1. A `Containerfile` that builds an image with the generator and all the required MIBs.

## Generating the Configuration

Run the config generator image, bind mounting the directory containing `generator.yml` to `/config`:

```
podman run --rm -v "$PWD:/config" -w /config ghcr.io/ocp-on-nerc/snmp-config-generator:latest \
  generate -m /mibs
```

If you are running on a system using SELinux, add `:z` to the bind mount:

```
podman run --rm -v "$PWD:/config:z" -w /config ghcr.io/ocp-on-nerc/snmp-config-generator:latest \
  generate -m /mibs
```

This will produce `snmp.yml` in the current directory.

[snmp-exporter]: https://github.com/prometheus/snmp_exporter
