PUB_TIMER_FREQ:100 // pub freq in millisecs - NEED TO BE AT LEAST 50ms for trigger timer (limit on SP API)
PUB_TIMER_MSG:100  // num rows per pub
syms:`AAPL`GOOG`FDL`NVDA
sides:`buy`sell
exch:`NYSE`LSE`SSE

// RT PRefix and Stream Name
rt_prefix: "rt-"
rt_stream: `$"kxi-itp"

// read on a trigger of timer
period:`timespan$1e6*PUB_TIMER_FREQ
startAt: 00:00:00.000;

genData:{
    ts:.z.p-reverse `timespan$period*til[PUB_TIMER_MSG]%PUB_TIMER_MSG;
    flip `time`sym`exch`side`price`size!enlist[ts],PUB_TIMER_MSG?'(syms;sides;exch;100.;10000i)
  }

// run at the start
.qsp.onStart[{[] .qsp.triggerRead `mcpTrigTime}]

.qsp.run
    .qsp.read.fromExpr["genData[]"; .qsp.use `trigger`name!((`timer; period; startAt); `mcpTrigTime)]
    .qsp.write.toStream[`trade;rt_stream;.qsp.use `prefix`deduplicate!(rt_prefix;1b)]