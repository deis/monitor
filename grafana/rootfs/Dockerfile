FROM quay.io/deis/base:0.2.0

COPY . /

RUN apt-get update \
	&& apt-get install -y libfontconfig \
	&& curl -sL -o /usr/share/grafana/envtpl https://github.com/arschles/envtpl/releases/download/0.2.3/envtpl_linux_amd64 \
	&& chmod +x /usr/share/grafana/envtpl \
	&& curl -so /tmp/grafana.deb https://grafanarel.s3.amazonaws.com/builds/grafana_3.0.4-1464167696_amd64.deb \
	&& dpkg -i /tmp/grafana.deb \
	&& rm /tmp/grafana.deb \
	&& rm /etc/grafana/grafana.ini \
	&& chmod +x /usr/share/grafana/start-grafana \
	&& chmod 644 /usr/share/grafana/grafana.ini.tpl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man /usr/share/doc

WORKDIR /usr/share/grafana
CMD ["./start-grafana"]
EXPOSE 3000

ENV WORKFLOW_RELEASE 2.0.0
