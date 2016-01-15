#!/usr/bin/env bash

set -eo pipefail

[[ $DEBUG ]] && set -x

echo "monitor: starting prometheus"
/bin/prometheus -config.file=/etc/prometheus/prometheus.yml -alertmanager.url=http://deis-monitor-alert.default.cluster.local:9093/ &
SERVICE_PID=$!
echo $SERVICE_PID > /var/spool/prometheus.pid
echo "monitor: monitor has been started in background with pid: ${SERVICE_PID}"

wait
