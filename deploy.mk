install:
	helm upgrade monitor ../charts/monitor --install --namespace deis --set grafana.org=${IMAGE_PREFIX},grafana.docker_tag=${VERSION},influxdb.org=${IMAGE_PREFIX},influxdb.docker_tag=${VERSION},telegraf.org=${IMAGE_PREFIX},telegraf.docker_tag=${VERSION}


upgrade: 
	helm upgrade monitor ../charts/monitor --namespace deis --set grafana.org=${IMAGE_PREFIX},grafana.docker_tag=${VERSION},telegraf.org=${IMAGE_PREFIX},telegraf.docker_tag=${VERSION},influxdb.org=${IMAGE_PREFIX},influxdb.docker_tag=${VERSION}

uninstall:
	helm delete monitor --purge