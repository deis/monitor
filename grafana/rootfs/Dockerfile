FROM grafana/grafana:2.6.0

RUN apt-get update && \
    apt-get install -y curl && \
    rm /etc/grafana/grafana.ini

ADD https://github.com/arschles/envtpl/releases/download/0.1.2/envtpl_linux_amd64 /usr/share/grafana/envtpl

COPY dashboards /usr/share/grafana/dashboards
COPY start-grafana /usr/share/grafana/start-grafana
COPY grafana.ini.tpl /usr/share/grafana/grafana.ini.tpl

RUN chmod +x /usr/share/grafana/envtpl && \
    chmod +x /usr/share/grafana/start-grafana && \
    chmod 644 /usr/share/grafana/grafana.ini.tpl

EXPOSE 3000
WORKDIR /usr/share/grafana
ENTRYPOINT ["./start-grafana"]