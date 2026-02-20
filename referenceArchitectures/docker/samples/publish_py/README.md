# External Python Publisher Example

# Introduction

This directory contains an example of an external (non-TLS) Python publisher. It uses the `kxi-rtpy` package and is similar to Python publisher described in the [RT Python interface documentation](https://code.kx.com/insights/microservices/rt/sdks/python-sdk.html).

The `config.json` file contains the RT configuration. See the [RT Interfaces Getting Started](https://code.kx.com/insights/microservices/rt/sdks/getting-started-sdks.html) guide for more information.

## Running the example

Create a Python virtual environment, e.g.

```bash
python3 -m venv ~/.venv/my_venv
source ~/.venv/my_venv/bin/activate
```

Update pip andinstall deps

```bash
pip install --upgrade pip
pip install pandas
pip install pyarrow
pip --no-input install --extra-index-url https://portal.dl.kx.com/assets/pypi kxi-rtpy
```

Run the example:

```bash
export PYKX_UNLICENSED=true
python3 sample.py
```
