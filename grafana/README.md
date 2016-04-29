# Grafana
[![Docker Repository on Quay](https://quay.io/repository/deisci/grafana/status "Docker Repository on Quay")](https://quay.io/repository/deisci/grafana)

## Description
[Grafana](https://grafana.org/) is a graphing application built for time series data. It natively supports influxdb and provides great dashboarding support. This project is focused on provided a grafana installation that can be run within a kubernetes installation. The grafana application is agnostic to [Workflow](https://github.com/deis/workflow) and can be installed as a stand alone system with the monitoring suite.

## Development
The provided `Makefile` has various targets to help support building and publishing new images into a kubernetes cluster.

### Environment variables
There are a few key environment variables you should be aware of when interacting with the `make` targets.

* `BUILD_TAG` - The tag provided to the docker image when it is built (defaults to the git-sha)
* `SHORT_NAME` - The name of the image (defaults to `grafana`)
* `DEIS_REGISTRY` - This is the registry you are using (default `dockerhub`)
* `IMAGE_PREFIX` - This is the account for the registry you are using (default `deis`)

### Make targets

* `make build` - Build docker image
* `make push` - Push docker image to a registry
* `make install` - Install all necessary components into kubernetes cluster (does not install telegraf or influx)
* `make uninstall` - Remove grafana from kubernetes
* `make upgrade` - Replaces the running grafana instance with a new one

The typical workflow will look something like this - `DEIS_REGISTRY=quay.io/ IMAGE_PREFIX=foouser make build push upgrade`