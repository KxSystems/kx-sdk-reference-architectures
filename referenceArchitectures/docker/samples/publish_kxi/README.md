# Publishing data via the kdb Insights Python API

## Introduction

This directory demonstrates how to publish data (via RT) using the [kdb Insights Python API](https://code.kx.com/insights/1.8/api/kxi-python/index.html).

## Running the example

1. Make sure kdb Insights has been successfully deployed before running this example
1. Ensure $QLIC is set to a valid KDB+ license location

Create a Python virtual environment, e.g.

```bash
python3 -m venv ~/.venv/my_venv
source ~/.venv/my_venv/bin/activate
```

Update pip and install `kxi`:

```bash
pip install --upgrade pip
pip install --extra-index-url https://portal.dl.kx.com/assets/pypi "kxi[all]>=1.14.0"
```

Publish a csv file:

```bash
python sample.py --type csv
```

Publish a parquet file:

```bash
python sample.py --type parquet
```
