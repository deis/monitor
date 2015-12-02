#!/usr/bin/env bash

set -eo pipefail

[[ $DEBUG ]] && set -x

export ETCD_PORT=${DEIS_ETCD_1_SERVICE_PORT_CLIENT:-4001}
export ETCD_HOST=${DEIS_ETCD_1_SERVICE_HOST:-$HOST}
export ETCD="$ETCD_HOST:$ETCD_PORT"
export ETCD_PATH=${ETCD_PATH:-/deis/monitor}
export ETCD_TTL=${ETCD_TTL:-20}

until etcdctl --no-sync -C "$ETCD" ls >/dev/null 2>&1; do
	echo "monitor: waiting for etcd at ${ETCD}..."
	sleep $((ETCD_TTL/2))  # sleep for half the TTL
done

until confd -onetime -node "$ETCD" --confdir /etc/confd --log-level error; do
	echo "monitor: waiting for confd to write initial templates..."
	sleep $((ETCD_TTL/2))  # sleep for half the TTL
done

set +e

# @fixme: how do we fix race conditions for components being started in random orders
# right now, the order is etcd, alertmanager and then prometheus.
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

wait
