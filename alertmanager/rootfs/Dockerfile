FROM prom/alertmanager:0.0.4

USER root

WORKDIR /tmp

RUN apk add --update-cache curl bash sudo && rm -rf /var/cache/apk/*

COPY . /

EXPOSE 9093

ENTRYPOINT [ "/usr/local/bin/boot" ]
