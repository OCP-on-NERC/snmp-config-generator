FROM quay.io/prometheus/snmp-generator:v0.28.0

COPY ./mibs /mibs/
