FROM quay.io/deis/base:v0.3.6

COPY . /

RUN apt-get update && \
	apt-get install -y libfontconfig && \
	curl -fsSL -o /usr/share/grafana/envtpl https://github.com/arschles/envtpl/releases/download/0.2.3/envtpl_linux_amd64 && \
	chmod +x /usr/share/grafana/envtpl && \
	curl -fsSo /tmp/grafana.deb https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_4.3.2_amd64.deb && \
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
    gunzip -f $COPYRIGHT_TAR.gz; tar -rf $COPYRIGHT_TAR /usr/share/doc/*/copyright; gzip $COPYRIGHT_TAR && \
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
