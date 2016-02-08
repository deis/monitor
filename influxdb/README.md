# InfluxDB

## Description
This is an alpine 3.2 based image for running influxdb 0.10.0-rc1. Props goes to @jalatera's alpine image from which this one is based - https://github.com/jalateras/docker-influxdb.

## Configuration
Right now the configuration is completely static but eventually I hope to use the [envtpl](https://github.com/arschles/envtpl) project to help provide a more robust solution.

## Development
There is a make file provided with the project that can build the image, push it to a registry, and deploy it to a kubernetes cluster.

### Environment Variables
* `DEIS_REGISTRY` : leave blank for dockerhub otherwise provide a valid url like `quay.io`
* `BUILD_TAG`: This is the tag that will be applied to the image when built
* `IMAGE_PREFIX`: The account in the registry (quay.io/jchauncey)

### Make targets
* `info`: Print out what information will be used to build the docker image
* `docker-build`: Builds the docker image
* `docker-push`: Pushes the image to the specified registry
* `kube-delete`: Remove the service, proxy pod, and replication controller from kubernetes
* `kube-create`: Create the service, proxy pod, and replication controller in kubernetes
* `kube-update`: Remove the replication controller and create a new one (this is useful for publishing new images)
* `update-manifests`: This is a helpful target that is used to generate a temporary manifest with the dev image set in the `image` stanza.