# External Q Publisher Example

## Introduction

This directory contains an example of an external (non-TLS) Q publisher. It uses the `rt.qpk` and is similar to Q publisher described in the [RT Quickstart](https://code.kx.com/insights/microservices/rt/quickstart/docker-compose.html#publishing).

## Running the example

Download and extract the `rt.pk`:

```bash
curl -LO https://portal.dl.kx.com/assets/raw/rt/1.17.2/rt.1.17.2.qpk
unzip rt.1.17.2.qpk
```

Run the example:

```q
q sample.q
```
