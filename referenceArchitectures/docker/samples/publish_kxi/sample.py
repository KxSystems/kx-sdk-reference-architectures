from  argparse import ArgumentParser
import os
from datetime import datetime, timedelta
import pandas as pd
import pyarrow as pa
import pyarrow.parquet as pq
from kxi.publish.rtpublisher import RtPublisher
from kxi.publish.data_preprocessor import DataPreprocessor
from kxi.query import Query


def create_dict():
    start = datetime.now()
    end = start + timedelta(minutes=15)

    return {
        'vendor': ['Happy Cabs'],
        'pickup': [start],
        'dropoff': [end],
        'passengers': [2],
        'distance': [5.25],
        'fare': [20.50],
        'extra': [0],
        'tax': [0],
        'tip': [2],
        'tolls': [0],
        'fees': [0],
        'total': [22.50],
        'payment_type': ['AMEX']
    }


def create_data_files():
    data = create_dict()
    df = pd.DataFrame(data)
    df.to_csv('/tmp/taxi.csv',index=False)
    table = pa.Table.from_pandas(df)
    pq.write_table(table, '/tmp/taxi.parquet')


create_data_files()

parser = ArgumentParser(description='Publish data using the kdb Insights Python API')
parser.add_argument('-t', '--type', choices=['csv', 'parquet'],
                    default='csv', help='Type of data file to process')

args = parser.parse_args()

data = f'/tmp/taxi.{args.type}'
table = 'taxi'

os.environ['INSIGHTS_URL'] = 'http://localhost:9200'
os.environ['KXI_C_SDK_APP_LOG_PATH']='/tmp'

query = Query(usage='MICROSERVICES')

params = {
    'path': '/tmp/rt',
    'stream': 'data',
    'publisher_id': 'pypub',
    'endpoints': ':127.0.0.1:5002',
}

pub = RtPublisher.create(**params)
#print(pub.rt_params.configUrl)
pub.fetch_schemas(query)
with pub:
    print(f'Publishing {data}')
    for item in DataPreprocessor.iter_data(data, chunksize=10000):
        pub.insert(table, item)

print(f'Finished publishing {data}')
