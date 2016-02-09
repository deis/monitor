SHORT_NAME ?= chronograf
BUILD_TAG ?= git-$(shell git rev-parse --short HEAD)
DEIS_REGISTRY ?= ${DEV_REGISTRY}
IMAGE_PREFIX ?= deis
IMAGE_LATEST := ${DEIS_REGISTRY}${IMAGE_PREFIX}/${SHORT_NAME}:latest
IMAGE := ${DEIS_REGISTRY}${IMAGE_PREFIX}/${SHORT_NAME}:${BUILD_TAG}

info:
	@echo "Build tag:  ${BUILD_TAG}"
	@echo "Registry:   ${DEIS_REGISTRY}"
	@echo "Image:      ${IMAGE}"

docker-build:
	docker build -t $(IMAGE_LATEST) .
	docker tag -f $(IMAGE_LATEST) $(IMAGE)

docker-push:
	docker push ${IMAGE}

kube-delete: update-manifests
	-kubectl delete -f manifests/deis-monitor-chronograf-svc.yaml
	-kubectl delete -f manifests/deis-monitor-chronograf-proxy-pod.yaml
	-kubectl delete -f manifests/deis-monitor-chronograf-rc.tmp.yaml

kube-create: update-manifests
	kubectl create -f manifests/deis-monitor-chronograf-svc.yaml
	kubectl create -f manifests/deis-monitor-chronograf-rc.tmp.yaml
	kubectl create -f manifests/deis-monitor-chronograf-proxy-pod.yaml

kube-update: update-manifests
	kubectl delete -f manifests/deis-monitor-chronograf-rc.tmp.yaml
	kubectl create -f manifests/deis-monitor-chronograf-rc.tmp.yaml

update-manifests:
	sed 's#\(image:\) .*#\1 $(IMAGE)#' manifests/deis-monitor-chronograf-rc.yaml > manifests/deis-monitor-chronograf-rc.tmp.yaml
