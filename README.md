# SAP Cloud Connector Docker Image

## This image is built with

- CentOS
- SAP JVM
- SAP Cloud Connector

## Release notes

- v3
    - SAP Cloud Connector 2.13.2
- v2
    - SAP Cloud Connector 2.13.1
    - SAP JVM 8.1.075
    - CentOS 7

## Pre-Built Docker Image

Docker Hib : https://hub.docker.com/r/makoto2600/sapcc

```yaml
---
version: "2.1"
services:
  sapcc:
    image: makoto2600/sapcc:latest
    container_name: sapcc
    network_mode: host
    restart: unless-stopped
```
