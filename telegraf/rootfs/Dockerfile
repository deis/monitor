FROM alpine:3.2
MAINTAINER Jonathan Chauncey "<jchauncey@deis.com>"

ENV TELEGRAF_VERSION "0.10.0_linux_amd64"

RUN apk --update add bash

# The download links for the zip of telegraf are broken.
# So for now Im building this locally and copying it into the build context.
ADD https://bintray.com/artifact/download/jchauncey/telegraf/telegraf/telegraf /telegraf
ADD https://github.com/arschles/envtpl/releases/download/0.1.1/envtpl_linux_amd64 /envtpl
COPY start-telegraf /start-telegraf
COPY config.toml.tpl /config.toml.tpl

RUN chmod +x /telegraf
RUN chmod +x /envtpl
RUN chmod +x /start-telegraf

ENTRYPOINT ["/start-telegraf"]
