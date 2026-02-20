# Publishing data via the Java interface

## Introduction

This directory demonstrates how to publish data (via Java interface) using the [kdb Insights Java interface](https://code.kx.com/insights/microservices/rt/sdks/java-sdk.html).

The `config.json` file contains the RT configuration. See the [RT Interfaces Getting Started](https://code.kx.com/insights/microservices/rt/sdks/getting-started-sdks.html) guide for more information.

## Prerequisites

Make sure to log in to `portal.dl.kx.com` with your credentials in order to pull the required `portal.dl.kx.com/rtdemo` image which contains a Java runtime with `kxi-java-sdk`.

```
docker login $KX_REGISTRY -u $KX_USER -p $KX_PASS
```

Make sure the InsightsDB has been deployed.

## Running the example

From `samples` directory run the docker compose build:

```
docker compose -f publish_java/compose-java-ingest.yaml build
```

Publish the `taxi.csv` data:

```
docker compose -f publish_java/compose-java-ingest.yaml up
```
## Publisher data persistence

To keep the content of `/var/rt-data` of the java publisher defined in `RT_LOG_PATH` and `RT_REP_DIR` when the container finishes, add the `volumes` section to the compose file:

```
  java-pub:
    ...
    volumes:
      - ./samples/publish_java/data/:/var/rt-data/
```
