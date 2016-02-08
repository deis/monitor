# Telegraf

## Description
This is an alpine based image for running telegraf within a kubernetes cluster.

## Configuration
Telegraf configuration is based largely on a toml file that is passed in when the binary starts. The issue with doing this in a containerized environment is how can you "dynamically" build this file based on values passed into the container at runtime. Therefore, this image relies on a project called [envtpl](https://github.com/arschles/envtpl) to produce the telegraf configuration file. It can take environment variables and through using go templates produce the necessary stanzas in the toml file to start telegraf. Currently, the go template only supports basic if checks and outputting values that have been set.

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
* `kube-delete`: Remove the daemonset from kubernetes
* `kube-create`: Create the daemonset in kubernetes
* `kube-update`: Remove the daemonset and create a new one (this is useful for publishing new images)
* `update-manifests`: This is a helpful target that is used to generate a temporary manifest with the dev image set in the `image` stanza.