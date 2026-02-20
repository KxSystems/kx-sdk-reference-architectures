{system"cd rt";system"l startq.q";system"cd .."}[];

1 "RT configuration:\n";
show params:(`path`stream`publisher_id`cluster)!("/tmp/rt";"data";"qpub";enlist ":127.0.0.1:5002")
1 "\n";

table:$[""~t:getenv`PUB_TABLE;`taxi; `$t];
1 "\nPublishing to ", (string table), " table\n";

p:.rt.pub params

now:.z.p
fare:10e
1 "Data:\n";
t:([]vendor:enlist `Midtown;pickup:now;dropoff:now+00:10;passengers:1h;distance:5e;fare:fare;extra:0e;tax:fare * .15e;tip:fare * .1e;tolls:0e;fees:0e;total:fare * 1.25e;payment_type:`Debit)
show flip t

1 "\nPublishing data\n";
p (`upd; table; t);
system "sleep 2";

exit 0
