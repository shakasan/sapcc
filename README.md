# SAP Cloud Connector Docker Image

Dockerfile to build a SAP Cloud Connector (SAPCC) Docker image.

The goal of this image is to deploy in seconds a fully working SAP Cloud Connector.

## This image is built with

- CentOS
- SAP JVM
- SAP Cloud Connector

## Release notes

- v5
  - SAP JVM 8.1.083
  - SAP Cloud Connector 2.14.0.1
  - Cloud Connector configuration is saved in Docker volumes (/opt/sap/scc/config & /opt/sap/scc/scc_config)
- v4
  - SAP JVM 8.1.078
- v3
  - SAP Cloud Connector 2.13.2
- v2
  - SAP Cloud Connector 2.13.1
  - SAP JVM 8.1.075
  - CentOS 7

## Pre-Built Docker Image

You can use a pre-built Docker Image available on Docker Hub with the Docker Compose example below.

Docker Hub : https://hub.docker.com/r/makoto2600/sapcc

```yaml
---
version: "2.1"
services:
  sapcc:
    image: makoto2600/sapcc:latest
    container_name: sapcc
    volumes:
      - sapcc_config:/opt/sap/scc/config
      - sapcc_scc_config:/opt/sap/scc/scc_config
    network_mode: host
    restart: unless-stopped
volumes:
  sapcc_config:
  sapcc_scc_config:
```
