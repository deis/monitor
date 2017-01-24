FROM quay.io/deis/base:v0.3.6

RUN adduser --system \
	--shell /bin/bash \
	--disabled-password \
	--home /home/influxdb \
	--group \
	influxdb

COPY . /

RUN curl -SL -o /home/influxdb/envtpl https://github.com/arschles/envtpl/releases/download/0.2.3/envtpl_linux_amd64 \
	&& chmod +x /home/influxdb/envtpl \
	&& curl -SL -o /tmp/influxdb.deb https://dl.influxdata.com/influxdb/releases/influxdb_1.1.1_amd64.deb \
	&& dpkg -i /tmp/influxdb.deb \
	&& rm /tmp/influxdb.deb \
	&& mkdir -p /data \
	&& chown influxdb:influxdb /data \
	&& chown -R influxdb:influxdb /home/influxdb \
	&& chmod +x /home/influxdb/start-influx

VOLUME /data

USER influxdb
WORKDIR /home/influxdb
CMD ["./start-influx"]

# Expose the admin port
EXPOSE 8083
# Expose the ssl http api port
EXPOSE 8084
# Expose the http api port
EXPOSE 8086
