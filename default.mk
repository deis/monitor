SHELL := /bin/bash

# all monitor components share/use the following targets/exports
DOCKER_HOST = $(shell echo $$DOCKER_HOST)
BUILD_TAG ?= git-$(shell git rev-parse --short HEAD)
DEIS_REGISTRY ?= ${DEV_REGISTRY}
IMAGE_PREFIX ?= deis

include ../includes.mk
include ../versioning.mk

TEST_ENV_PREFIX := docker run --rm -v ${CURDIR}:/bash -w /bash quay.io/deis/shell-dev

build: docker-build
push: docker-push
deploy: check-kubectl docker-build docker-push upgrade

docker-build:
	docker build ${DOCKER_BUILD_FLAGS} -t ${IMAGE} rootfs
	docker tag ${IMAGE} ${MUTABLE_IMAGE}

clean: check-docker
	docker rmi $(IMAGE)

KD = kubectl --namespace=deis
upgrade:
	${KD} patch ${RESOURCE_TYPE} deis-monitor-${SHORT_NAME} \
		--type='json' \
		-p='[ \
			{"op": "replace", "path": "/spec/strategy", "value":{"type":"Recreate"}}, \
			{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value":"$(IMAGE)"}, \
			{"op": "replace", "path": "/spec/template/spec/containers/0/imagePullPolicy", "value":"Always"} \
		]'
	@if [ "${RESOURCE_TYPE}" == "daemonset" ]; then \
		echo "Deleting daemonset pods as they aren't yet recreated when daemonset is patched..."; \
		${KD} delete $$(${KD} get pod -o name | grep "${SHORT_NAME}"); \
	fi

test: test-style

test-style:
	${TEST_ENV_PREFIX} shellcheck $(SHELL_SCRIPTS)

.PHONY: build push docker-build clean upgrade deploy test test-style
