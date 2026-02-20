/ Open a connection to the service gateway process
h:hopen 5050
/ Query the taxi table using the getData API
r:h(`.kxi.getData;enlist[`table]!enlist`taxi;`;()!())
/ Display the results
r[1]
