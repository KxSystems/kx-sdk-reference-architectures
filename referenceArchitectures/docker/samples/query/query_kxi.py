from datetime import datetime, timedelta
import kxi.query
import os
from pprint import pprint


def example_sql_query(client):
    print('\nSQL query example...')
    res = client.sql('select * from taxi')
    pprint(res[:2])

def example_get_data_query(client):
    print('\nget_data API example...')
    start = datetime.now() - timedelta(days=31)
    end = datetime.now() + timedelta(hours=24)
    res = client.get_data('taxi', start_time=start, end_time=end)
    pprint(res[:2])

def display_meta_data(client):
    print('Meta data...')
    pprint(client.get_meta())


os.environ['INSIGHTS_URL'] = 'http://localhost:8080'
client = kxi.query.Query(data_format='application/json', usage='MICROSERVICES')

display_meta_data(client)
example_sql_query(client)
example_get_data_query(client)
