FROM quay.io/deis/base:v0.3.4

COPY . /

RUN mkdir -p /usr/local/bin/ \
	&& curl -SL -o /tmp/telegraf.deb https://dl.influxdata.com/telegraf/releases/telegraf_1.0.0_amd64.deb \
    && dpkg -i /tmp/telegraf.deb \
    && rm /tmp/telegraf.deb \
    && chmod +x /usr/bin/telegraf \
	&& curl -sSL -o /usr/bin/envtpl https://github.com/arschles/envtpl/releases/download/0.2.3/envtpl_linux_amd64 \
	&& chmod +x /usr/bin/envtpl

CMD ["/start-telegraf"]
