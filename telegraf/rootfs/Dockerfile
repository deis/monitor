FROM quay.io/deis/base:0.2.0

COPY . /

RUN mkdir -p /usr/local/bin/ \
	&& curl -SL -o /tmp/telegraf.deb https://dl.influxdata.com/telegraf/releases/telegraf_0.13.1_amd64.deb \
	&& dpkg -i /tmp/telegraf.deb \
	&& rm /tmp/telegraf.deb \
	&& curl -SL -o /usr/bin/envtpl https://github.com/arschles/envtpl/releases/download/0.2.3/envtpl_linux_amd64 \
	&& chmod +x /usr/bin/envtpl

CMD ["/start-telegraf"]

ENV WORKFLOW_RELEASE 2.0.0
