#This dockerfile is based on https://github.com/jalateras/docker-influxdb
FROM alpine:3.2
MAINTAINER Jonathan Chauncey "<jchauncey@deis.com>"

ENV INFLUX_VERSION "v0.10.0-rc1"
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
  apk add --update bash wget git mercurial bzr go && \
  mkdir -p $GOPATH/src/github.com/influxdb && \
  cd $GOPATH/src/github.com/influxdb && \
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
  apk del --purge wget git mercurial bzr go  && \
  rm -rf /var/cache/apk/* /tmp/* /var/tmp/* $GOPATH

RUN mkdir -p /data
VOLUME /data

COPY config.toml /influxdb/config.toml

USER influxdb
CMD ["/influxdb/influxd", "-config", "/influxdb/config.toml"]
