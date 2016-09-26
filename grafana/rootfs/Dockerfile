FROM quay.io/deis/base:0.3.1

COPY . /

RUN apt-get update && \
	apt-get install -y libfontconfig && \
	curl -sL -o /usr/share/grafana/envtpl https://github.com/arschles/envtpl/releases/download/0.2.3/envtpl_linux_amd64 && \
	chmod +x /usr/share/grafana/envtpl && \
	curl -so /tmp/grafana.deb https://grafanarel.s3.amazonaws.com/builds/grafana_3.1.0-1468321182_amd64.deb && \
	dpkg -i /tmp/grafana.deb && \
	rm /tmp/grafana.deb && \
	rm /etc/grafana/grafana.ini && \
	chmod +x /usr/share/grafana/start-grafana && \
	chmod 644 /usr/share/grafana/grafana.ini.tpl && \
    # cleanup
    apt-get autoremove -y && \
    apt-get clean -y && \
    # package up license files if any by appending to existing tar
    COPYRIGHT_TAR='/usr/share/copyrights.tar'; \
    gunzip $COPYRIGHT_TAR.gz; tar -rf $COPYRIGHT_TAR /usr/share/doc/*/copyright; gzip $COPYRIGHT_TAR && \
    rm -rf \
        /usr/share/doc \
        /usr/share/man \
        /usr/share/info \
        /usr/share/locale \
        /var/lib/apt/lists/* \
        /var/log/* \
        /var/cache/debconf/* \
        /etc/systemd \
        /lib/lsb \
        /lib/udev \
        /usr/lib/x86_64-linux-gnu/gconv/IBM* \
        /usr/lib/x86_64-linux-gnu/gconv/EBC* && \
    bash -c "mkdir -p /usr/share/man/man{1..8}"

WORKDIR /usr/share/grafana
CMD ["./start-grafana"]
EXPOSE 3000
