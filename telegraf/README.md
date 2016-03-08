# Telegraf

## Description
This is an alpine based image for running telegraf within a kubernetes cluster.

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
