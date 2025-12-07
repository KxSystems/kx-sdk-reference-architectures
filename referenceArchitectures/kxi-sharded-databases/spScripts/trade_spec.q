// Schemas
tradeSchema:([]time:`timestamp$();sym:`symbol$();exch:`symbol$();side:`symbol$();price:`float$();size:`long$();tradeID:`guid$());

syms:`$("EUR/USD";"USD/JPY";"GBP/USD";"USD/CHF";"AUD/USD") /ccy pairs
shard:last -3_ "-" vs string .z.h
exchs:`$"SP_",shard
sides:`B`S
prices:syms!45.15 191.10 178.50 128.04 341.30 /starting prices 
n:10 /number of rows per update
getmovement:{[s] rand[0.0001]*prices[s]} /get a random price movement 
/generate trade price
getprice:{[s] prices[s]+:rand[1 -1]*getmovement[s]; prices[s]} 

.qsp.run
    .qsp.read.fromCallback[`publishT]
    //.qsp.map[{[data] `time`spTime xcols update spTime:.z.P from data}]
    .qsp.write.toStream[`trade;"kxi-db-exch-",shard; .qsp.use enlist[`prefix]!enlist("rt-")]

/timer functions
.pub.all:{
    s:n?syms;
    0N!"this SP is, ",string .z.h;
    sd:n?sides;
    publishT flip (cols tradeSchema)!(n#.z.P;s;n#exchs;sd;getprice'[s];n?1000;n?0Ng);
    };

.qsp.onStart {
    // Send a message every 10000 ms
    .tm.add[`.pub.all; (`.pub.all; ()); 10000; 0]
    };
