#!/usr/bin/env bash

set -eo pipefail

[[ $DEBUG ]] && set -x

# configure etcd
export ETCD_PORT="${ETCD_PORT:-4001}"
export ETCD="$HOST:$ETCD_PORT"
export ETCD_PATH="${ETCD_PATH:-/deis/monitor}"
export ETCD_TTL="${ETCD_TTL:-20}"

until etcdctl --no-sync -C "$ETCD" ls >/dev/null 2>&1; do
	echo "monitor: waiting for etcd at ${ETCD}..."
	sleep $((ETCD_TTL/2))  # sleep for half the TTL
done

until confd -onetime -node "$ETCD" --confdir /etc/confd --log-level error; do
	echo "monitor: waiting for confd to write initial templates..."
	sleep $((ETCD_TTL/2))  # sleep for half the TTL
done

set +e

OPTS=""

if ALERT_MANAGER="$(etcdctl -C "$ETCD" get /deis/monitor/alertManagerUri)"; then
  OPTS="-alertmanager.url=$ALERT_MANAGER"
fi

set -e

confd -node "$ETCD" --confdir /etc/confd --log-level info --interval 5 &

echo "monitor: starting prometheus"
/bin/prometheus -config.file=/etc/prometheus/prometheus.yml $OPTS &
SERVICE_PID=$!
echo $SERVICE_PID > /var/spool/prometheus.pid
echo "monitor: monitor has been started in background with pid: ${SERVICE_PID}"

# @fixme: hax. how else can we accomplish this?.
echo "monitor: updating etcd node list in... etcd"
while true; do
  for uri in $(etcdctl -C "$ETCD" member list | awk '{print $4}' | awk -F= '{print $2}' | awk -F, '{print $1}'); do
    host=$(echo $uri | awk -F: '{print $2}')
    port=$(echo $uri | awk -F: '{print $3}')
    if ! etcdctl -C "$ETCD" get /deis/monitor/endpoints/etcd/$host >/dev/null 2>&1; then
      etcdctl  -C "$ETCD" set /deis/monitor/endpoints/etcd/$host $port >/dev/null 2>&1;
    fi
  done
  sleep 60
done
