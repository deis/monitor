FROM quay.io/deis/base:0.3.1

COPY . /

RUN mkdir -p /usr/local/bin/ \
	&& curl -sSL -o /usr/bin/telegraf https://storage.googleapis.com/telegraf/telegraf \
  && chmod +x /usr/bin/telegraf \
	&& curl -sSL -o /usr/bin/envtpl https://github.com/arschles/envtpl/releases/download/0.2.3/envtpl_linux_amd64 \
	&& chmod +x /usr/bin/envtpl

CMD ["/start-telegraf"]
