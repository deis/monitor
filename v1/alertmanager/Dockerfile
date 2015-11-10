FROM prom/alertmanager:0.0.4

USER root

WORKDIR /tmp

RUN apk add --update-cache curl bash sudo && rm -rf /var/cache/apk/*

RUN curl -L  https://github.com/coreos/etcd/releases/download/v2.2.1/etcd-v2.2.1-linux-amd64.tar.gz -o /tmp/etcd-v2.2.1-linux-amd64.tar.gz

RUN tar xzvf /tmp/etcd-v2.2.1-linux-amd64.tar.gz

RUN cp /tmp/etcd-v2.2.1-linux-amd64/etcdctl /usr/local/bin/etcdctl && chmod +x /usr/local/bin/etcdctl

# install confd
RUN curl -sSL -o /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 \
    && chmod +x /usr/local/bin/confd

COPY rootfs /

EXPOSE      9093

ENTRYPOINT [ "/bin/boot.sh" ]

ENV DEIS_RELEASE 1.12.0-dev
