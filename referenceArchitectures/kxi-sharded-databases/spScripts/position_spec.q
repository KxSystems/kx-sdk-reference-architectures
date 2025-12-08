//Schemas
trade:([]time:`timestamp$();sym:`symbol$();exch:`symbol$();side:`symbol$();price:`float$();size:`long$();tradeID:`guid$());
position:([tenant:`$();sym:`$()]time:`timestamp$();pos:`long$());
/position:([]time:`timestamp$();sym:`$();tenant:`$();pos:`long$());
shard:last -3_ "-" vs string .z.h;
freq:enlist 55000 /publish frequency in ms

.data.updPosition:{[op;md;x]
  .debug.upd:x;
  res:$[98h=type x; raze .data.updPosition0[op;md]each x;99h=type x; .data.updPosition0[op;md;x];`];
  res}

.data.updPosition0:{[op;md;x]
  .debug.upd0:x;
  sz:$[x[`side]=`B; x`size; neg x`size];
  old:$[99h = type .qsp.get[op; md];`tenant`sym xkey enlist .qsp.get[op; md];`tenant`sym xkey .qsp.get[op; md]];
  new_sz:$[(99h<>type old) or null first exec pos from old where tenant in x`exch, sym in x`sym; sz; sz+first exec pos from old where tenant in x`exch, sym in x`sym];
  new:`tenant`sym`time`pos!(x`exch;x`sym;x`time;new_sz);
  upsert[`position] pos:cols[position]!(x`exch;x`sym;x`time;new_sz);
  .qsp.set[op; md] 0!old,res:select by tenant, sym from enlist new;
  0!res}

//Debugging
/.qsp.setTrace 5
/.qsp.enableDataTracing[];
/.kurl.setLogLevel `TRACE;

streamA: .qsp.read.fromStream[`trade;"kxi-db-exch-",shard; .qsp.use enlist[`prefix]!enlist("rt-")] .qsp.map[.data.updPosition; .qsp.use enlist[`state]!enlist first 0!position]
streamB: streamA .qsp.map[{.debug.p:x; select time, sym, tenant, position:pos from x}] .qsp.write.toStream[`position;"kxi-db-tenant-",shard;.qsp.use enlist[`prefix]!enlist("rt-")]

.qsp.run streamB