# InfluxDB
[![Docker Repository on Quay](https://quay.io/repository/deisci/influxdb/status "Docker Repository on Quay")](https://quay.io/repository/deisci/influxdb)

## Configuration
Right now the configuration is completely static but eventually I hope to use the [envtpl](https://github.com/arschles/envtpl) project to help provide a more robust solution.

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
* `make upgrade` - Replaces the running grafana instance with a new one

The typical workflow will look something like this - `DEIS_REGISTRY=quay.io/ IMAGE_PREFIX=foouser make build push upgrade`

### Accessing Admin UI
Included is a proxy pod that proxies the UI ports so they are accessible when doing local development. These ports are `8086` and `8083`. You can access the UI by going to the `http://<host_ip>:8083`.
