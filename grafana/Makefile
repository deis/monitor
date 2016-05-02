SHELL = /bin/bash

DOCKER_HOST = $(shell echo $$DOCKER_HOST)
BUILD_TAG ?= git-$(shell git rev-parse --short HEAD)
SHORT_NAME ?= grafana
DEIS_REGISTRY ?= ${DEV_REGISTRY}
IMAGE_PREFIX ?= deis

include versioning.mk

build: docker-build
push: docker-push
install: kube-install
uninstall: kube-delete
upgrade: kube-update

docker-build:
	docker build -t ${IMAGE} rootfs
	docker tag ${IMAGE} ${MUTABLE_IMAGE}

clean: check-docker
	docker rmi $(IMAGE)

update-manifests:
	sed 's#\(image:\) .*#\1 $(IMAGE)#' manifests/deis-monitor-grafana-rc.yaml > manifests/deis-monitor-grafana-rc.tmp.yaml

kube-install: update-manifests
	kubectl create -f manifests/deis-monitor-grafana-svc.yaml
	kubectl create -f manifests/deis-monitor-grafana-rc.tmp.yaml

kube-delete: update-manifests
	kubectl delete -f manifests/deis-monitor-grafana-svc.yaml
	kubectl delete -f manifests/deis-monitor-grafana-rc.tmp.yaml

kube-update: update-manifests
	kubectl delete -f manifests/deis-monitor-grafana-rc.tmp.yaml
	kubectl create -f manifests/deis-monitor-grafana-rc.tmp.yaml