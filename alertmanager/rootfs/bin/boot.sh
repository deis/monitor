#!/usr/bin/env bash

set -eo pipefail

[[ $DEBUG ]] && set -x

# configure etcd
export ETCD_PORT=${DEIS_ETCD_1_SERVICE_PORT_CLIENT:-4001}
export ETCD_HOST=${DEIS_ETCD_1_SERVICE_HOST:-$HOST}
export ETCD="$ETCD_HOST:$ETCD_PORT"
export ETCD_PATH=${ETCD_PATH:-/deis/monitor}
export ETCD_TTL=${ETCD_TTL:-20}

until etcdctl --no-sync -C "$ETCD" ls >/dev/null 2>&1; do
	echo "alertmanager: waiting for etcd at ${ETCD}..."
	sleep $((ETCD_TTL/2))  # sleep for half the TTL
done

until confd -onetime -node "$ETCD" --confdir /etc/confd --log-level error; do
	echo "alertmanager: waiting for confd to write initial templates..."
	sleep $((ETCD_TTL/2))  # sleep for half the TTL
done

confd -node "$ETCD" --confdir /etc/confd --log-level info --interval 5 &

echo "alertmanager: starting alertmanager"
/bin/alertmanager -config.file=/etc/alertmanager/alertmanager.yml $OPTS &
SERVICE_PID=$!
echo $SERVICE_PID > /var/spool/alertmanager.pid
echo "alertmanager: alertmanager has been started in background with pid: ${SERVICE_PID}"

wait
