FROM alpine:3.3
MAINTAINER Jonathan Chauncey "<jchauncey@deis.com>"

ENV TELEGRAF_VERSION=0.12.0
RUN \
    mkdir -p /usr/local/bin/ &&\
    apk --update add curl &&\
    curl -SL http://get.influxdb.org/telegraf/telegraf-${TELEGRAF_VERSION}-1_linux_amd64.tar.gz \
    | tar xzC / &&\
    apk del --purge curl && \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/*
# Alpine telegraf fix
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2


ENV ENVTPL_VERSION=0.1.2
ADD https://github.com/arschles/envtpl/releases/download/${ENVTPL_VERSION}/envtpl_linux_amd64 /usr/bin/envtpl
RUN chmod +x /usr/bin/envtpl

COPY start-telegraf /start-telegraf
COPY config.toml.tpl /config.toml.tpl

ENTRYPOINT ["/start-telegraf"]
