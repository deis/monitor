# [Telegraf](https://influxdata.com/time-series-platform/telegraf/)
[![Docker Repository on Quay](https://quay.io/repository/deisci/telegraf/status "Docker Repository on Quay")](https://quay.io/repository/deisci/telegraf)

## Description
Telegraf is a metrics collection daemon from InfluxData. It contains numerous input and output plugins that allows the user to customize what data they collect and where it is sent. This image is based on the official [deis base image](https://github.com/deis/docker-base).

## Configuration
Telegraf configuration is based largely on a toml file that is passed in when the binary starts. The issue with doing this in a containerized environment is how can you "dynamically" build this file based on values passed into the container at runtime. Therefore, this image relies on a project called [envtpl](https://github.com/arschles/envtpl) to produce the telegraf configuration file. It can take environment variables and through using go templates produce the necessary stanzas in the toml file to start telegraf. Currently, the go template only supports basic if checks and outputting values that have been set.

## Host information
You must do 2 things if you want to receive host level metrics from telegraf.
 * - Set the volume mounts for both `/sys` and `/proc`
 * - Set the environment variables `HOST_PROC` and `HOST_SYS` to the values of where `/sys` and `/proc` are mounted in the container. Example entries can be found in the [manifest](manifests/deis-monitor-telegraf-daemon.yaml).

 ## Environment Variables
 The configuration is driven via environment variables which are published to the `config.toml` file passed to telegraf when it starts. The following table gives the environment variable name and the default value if it is not set.

 | Name | Default | Description |
 |-----------|---------------|---------------|
 | AGENT_INTERVAL | 10s | Default data collection interval for all inputs |
 | AGENT_ROUND_INTERVAL | true | Rounds collection interval to 'interval' ie, if interval="10s" then always collect on :00, :10, :20, etc. |
 | AGENT_BUFFER_LIMIT | 10000 | Telegraf will cache metric_buffer_limit metrics for each output, and will flush this buffer on a successful write. |
 | AGENT_COLLECTION_JITTER | 0s | Collection jitter is used to jitter the collection by a random amount. Each plugin will sleep for a random time within jitter before collecting. This can be used to avoid many plugins querying things like sysfs at the same time, which can have a measurable effect on the system. |
 | AGENT_FLUSH_INTERVAL | 10s | Default data flushing interval for all outputs. You should not set this below interval. Maximum flush_interval will be flush_interval + flush_jitter |
 | AGENT_FLUSH_JITTER | 0s | Jitter the flush interval by a random amount. This is primarily to avoid large write spikes for users running a large number of telegraf instances. ie, a jitter of 5s and flush_interval 10s means flushes will happen every 10-15s. |
 | AGENT_DEBUG | false | Run telegraf in debug mode. |
 | AGENT_QUIET | false | Run telegraf in quiet mode. |
 | AGENT_HOSTNAME | NodeName | Override default hostname |


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

The typical workflow will look something like this - `DEIS_REGISTRY=quay.io/ IMAGE_PREFIX=foouser make build push upgrade``
