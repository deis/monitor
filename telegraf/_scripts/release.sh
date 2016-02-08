#!/usr/bin/env bash
#
# Build and push Docker images to Docker Hub and quay.io.
#
cd "$(dirname "$0")" || exit 1
echo "Building docker image and pushing to quay.io!"
DEIS_REGISTRY=quay.io/ BUILD_TAG=v2-beta make -C .. docker-build docker-push
echo "Building docker image and pushing to docker hub!"
BUILD_TAG=v2-beta make -C .. docker-build docker-push
