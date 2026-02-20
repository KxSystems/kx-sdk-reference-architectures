FROM portal.dl.kx.com/rtdemo:1.16.0

WORKDIR /app

COPY ./config.json .
COPY ./taxi.csv .
COPY ./run-java-pub.sh .

ENTRYPOINT ["/app/run-java-pub.sh"]
