FROM quay.io/deis/base:v0.3.6

COPY . /

RUN mkdir -p /usr/local/bin/ \
  # This will come back once the kuberentes plugin is release in November
  && curl -fsSL -o /tmp/telegraf.deb https://dl.influxdata.com/telegraf/releases/telegraf_1.3.0-1_amd64.deb \
  && dpkg -i /tmp/telegraf.deb \
  && rm /tmp/telegraf.deb \
  && curl -fsSL -o /usr/bin/envtpl https://github.com/arschles/envtpl/releases/download/0.2.3/envtpl_linux_amd64 \
	&& chmod +x /usr/bin/envtpl \
  && curl -fsSL -o /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 \
  && chmod +x /usr/bin/jq

CMD ["/start-telegraf"]
