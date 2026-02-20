from rtpy import Publisher, RTParams
import os
import pykx as kx
import pandas as pd


table_name = os.environ.get('PUB_TABLE')
if table_name is None:
    table_name = 'taxi'

print(f'Publishing to {table_name} table')

print('Reading CSV file')

df = pd.read_csv('../taxi.csv')

df["pickup"] = pd.to_datetime(df["pickup"], format="%Y-%m-%dT%H:%M:%S.%f")
df["dropoff"] = pd.to_datetime(df["dropoff"], format="%Y-%m-%dT%H:%M:%S.%f")
df['passengers'] = df['passengers'].transform(kx.ShortAtom)

for col in ['distance', 'fare', 'extra', 'tax', 'tip', 'tolls', 'fees', 'total']:
    df[col] = df[col].transform(kx.RealAtom)

print(df)

rt_cfg = f'file://{os.getcwd()}/config.json'
rt_dir = '/tmp/rt'

print('RT configuration:')
print(f'  config_url={rt_cfg}')
print(f'  rt_dir={rt_dir}\n')

params = RTParams(config_url=rt_cfg, rt_dir=rt_dir)

with Publisher(params) as pub:
    print('Publishing data\n')
    pub(table_name, df)
