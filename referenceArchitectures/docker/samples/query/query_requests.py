import requests
import json

print('Querying "taxi" table')
headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
}
query = {
    'table': 'taxi'
}
res = requests.post('http://localhost:8080/data',
                    headers=headers, data=json.dumps(query))

if res.status_code != 200:
    print(f'Request failed ({res.status_code}): {res.text}')
else:
    msg = res.json()
    rc = msg['header']['rc']
    if rc != 0:
        ai = msg['header']['ai']
        print(f'Query failed {rc}: {ai}')
    else:
        print('Query output')
        print(msg['payload'][:2])
        print('..')
