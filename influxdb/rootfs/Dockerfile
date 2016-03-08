#This dockerfile is based on https://github.com/jalateras/docker-influxdb
FROM alpine:3.2
MAINTAINER Jonathan Chauncey "<jchauncey@deis.com>"

ENV INFLUX_VERSION "v0.10.2"
ENV GOPATH /golang
ENV INFLUXDB_HOME /influxdb
ENV PATH $INFLUXDB_HOME:$PATH
WORKDIR /golang

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
  apk add --update bash wget git mercurial go && \
  mkdir -p $GOPATH/src/github.com/influxdata && \
  cd $GOPATH/src/github.com/influxdata && \
  git clone https://github.com/influxdata/influxdb.git && \
  cd influxdb && \
  git checkout -b $INFLUX_VERSION && \
  go get -t ./... && \
  go build ./... && \
  go install ./... && \
  mkdir -p $INFLUXDB_HOME && \
  cp $GOPATH/bin/influx* $INFLUXDB_HOME/   && \
  chown -R influxdb:influxdb $INFLUXDB_HOME && \
  mkdir -p /data /logs /config && \
  chown -R influxdb:influxdb /data /logs /config && \
  apk del --purge wget git mercurial go  && \
  rm -rf /var/cache/apk/* /tmp/* /var/tmp/* $GOPATH

RUN mkdir -p /data
VOLUME /data

ADD https://github.com/arschles/envtpl/releases/download/0.1.2/envtpl_linux_amd64 /influxdb/envtpl
COPY config.toml.tpl /influxdb/config.toml.tpl
COPY start-influx  /influxdb/start-influx

RUN chmod +x /influxdb/envtpl
RUN chmod +x /influxdb/start-influx

USER influxdb
WORKDIR /influxdb
ENTRYPOINT ["./start-influx"]
