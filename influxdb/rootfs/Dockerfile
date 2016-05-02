#This dockerfile is based on https://github.com/jalateras/docker-influxdb
FROM alpine:3.3
MAINTAINER Jonathan Chauncey "<jchauncey@deis.com>"

ENV INFLUX_VERSION 0.12.2

# Expose the admin port
EXPOSE 8083
# Expose the ssl http api port
EXPOSE 8084
# Expose the http api port
EXPOSE 8086

RUN \
  addgroup -S influxdb && \
  adduser -S -s /bin/bash -G influxdb influxdb

RUN \
    mkdir -p /usr/local/bin/ && \
    apk add -U ca-certificates wget curl bash

RUN curl -sSL https://raw.githubusercontent.com/andyshinn/alpine-pkg-glibc/master/andyshinn.rsa.pub -o /etc/apk/keys/andyshinn.rsa.pub && \
    curl -sSL https://github.com/andyshinn/alpine-pkg-glibc/releases/download/2.23-r1/glibc-2.23-r1.apk -O && \
    apk add glibc-2.23-r1.apk && rm /glibc-2.23-r1.apk

RUN curl -SL https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUX_VERSION}-1_linux_amd64.tar.gz | tar xzC / && \
    chown influxdb:influxdb /usr/bin/influx* && \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

RUN \
    mkdir -p /data && \
    chown influxdb:influxdb /data

VOLUME /data

ADD https://github.com/arschles/envtpl/releases/download/0.2.3/envtpl_linux_amd64 /home/influxdb/envtpl
COPY config.toml.tpl /home/influxdb/config.toml.tpl
COPY start-influx  /home/influxdb/start-influx

RUN chmod +x /home/influxdb/envtpl
RUN chmod +x /home/influxdb/start-influx

USER influxdb
WORKDIR /home/influxdb
ENTRYPOINT ["./start-influx"]
