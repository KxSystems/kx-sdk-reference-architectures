schema:(!) . flip (
    (`pickup_datetime       ; "p");
    (`dropoff_datetime      ; "p");
    (`vendor                ; "s");
    (`passengers            ; "h");
    (`distance              ; "e");
    (`rate_type             ; "*");
    (`store_and_fwd         ; "*");
    (`pickup_borough        ; "*");
    (`pickup_zone           ; "*");
    (`pickup_service_zone   ; "*");
    (`dropoff_borough       ; "*");
    (`dropoff_zone          ; "*");
    (`dropoff_service_zone  ; "*");
    (`payment_type          ; "s");
    (`fare                  ; "e");
    (`extra                 ; "e");
    (`tax                   ; "e");
    (`tip                   ; "e");
    (`toll                  ; "e");
    (`improvement_surcharge ; "*");
    (`congestion_surcharge  ; "*");
    (`total                 ; "e"));

exclude:`rate_type`store_and_fwd`pickup_borough`pickup_zone`pickup_service_zone`dropoff_borough`dropoff_zone`dropoff_service_zone`improvement_surcharge`congestion_surcharge;

.qsp.run
    .qsp.v2.read.fromAmazonS3["s3://kxs-prd-cxt-twg-roinsightsdemo/ny_taxi_data_2021_12.csv"; "eu-west-1"]
    .qsp.decode.csv[schema; .qsp.use enlist[`exclude]!enlist exclude]
    .qsp.transform.renameColumns[`pickup_datetime`dropoff_datetime`toll!`pickup`dropoff`tolls]
    .qsp.map[{ :`vendor`pickup`dropoff`passengers`distance`fare`extra`tax`tip`tolls`fees`total`payment_type xcols update fees:0e from x }]
    .qsp.v2.write.toDatabase[`taxi; .qsp.use `directWrite`target!(1b; "kxi-sm:10001")]
