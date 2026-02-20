#!/bin/sh
mkdir -p $RT_LOG_PATH
mkdir -p $RT_REP_DIR

/opt/java/openjdk/bin/java -jar /app/rtdemo.jar --tableName=taxi --configFile=/app/config.json --runCsvLoadDemo=/app/taxi.csv
