# Query samples for kdb SDK deployments

# Introduction

This directory contains examples of querying InsightsDB using the [kdb Insights Python API](https://code.kx.com/insights/api/kxi-python/index.html). It offers the capacity to query with standard python libraries `requests` and with the KX provided [`kxi` library](https://code.kx.com/insights/api/kxi-python/index.html) offering quickstart publish, query and subscribe APIs.

### Pre-requisite

1. The InsightsDB has been deployed
1. The `taxi` table contains recent data
  - If this is not the case run one of the publishing samples
1. Suitable puython environment initialised
    
    ```bash
    # Create and activate a python virtualenv
    python3 -m venv ~/.venv/my_venv
    source ~/.venv/my_venv/bin/activate

    # Upgrade pip and install dependencies
    pip install --upgrade pip
    pip install requests
    pip --no-input install --extra-index-url https://portal.dl.kx.com/assets/pypi kxi
    ```

## Query with `kxi` kdb Insights python library

The query sample file `query_kxi.py` can be run to query a running instance with `taxi` data. 

```bash
python3 query_kxi.py
```

The example program illustrates the following:

1. A [getMeta API](https://code.kx.com/insights/api/kxi-python/query.html#get_meta) call
2. A [SQL API](https://code.kx.com/insights/api/kxi-python/query.html#sql) call
3. A [getData API](https://code.kx.com/insights/api/kxi-python/query.html#get_data) call

Please note, to allow SQL API calls the `KXI_ALLOWED_SBX_APIS` environment variable must be set on the DAP and RC containers. This has already been done in the provided `docker compose` and `.env` files. See the [query configuration documentation](https://code.kx.com/insights/enterprise/database/configuration/package/query.html) for more details.

## Query with python `requests` library

The query sample file `query_requests.py` can be run to query a running instance with `taxi` data. 

```bash
python3 query_requests.py
```

The `query_requests.py` sample queries the `http://localhost:8080/data` endppoint routing to the [getData API](https://code.kx.com/insights/api/kxi-python/query.html#get_data) and prints a subset of the results to the terminal.