# NERC SNMP Exporter Configuration

This repository contains a `Containerfile` that builds an image with the generator and all the required MIBs to build the [snmp-exporter] configuration in use at the NERC.

[snmp-exporter]: https://github.com/prometheus/snmp_exporter

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

## Building the container image

The `config-generator` directory contains the components of the container image.

The `config-generator/mibs` directory contains the MIBs that are embedded in the image. The contents of this directory are built from a collection of upstream sources; the file `config-generator/miblist.txt` defines the sources of these MIBs.

After modifying `miblist.txt`, run the `build-mibs-db.sh` script to refresh the `mibs` directory.
