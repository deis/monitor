FROM ubuntu:14.04
MAINTAINER Jonathan Chauncey "<jchauncey@deis.com>"

ENV CHRONOGRAF_HOME /chronograf

RUN \
  apt-get update && \
  apt-get install -y -q wget && \
  groupadd chronograf && \
  useradd --create-home -g chronograf chronograf && \
  wget -q https://s3.amazonaws.com/get.influxdb.org/chronograf/chronograf_0.10.0_amd64.deb && \
  dpkg -i chronograf_0.10.0_amd64.deb

COPY config.toml /opt/chronograf/config.toml

USER chronograf
CMD ["/opt/chronograf/chronograf", "-config", "/opt/chronograf/config.toml"]