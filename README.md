# Deis Monitor v2

[![Build Status](https://travis-ci.org/deis/monitor.svg?branch=master)](https://travis-ci.org/deis/monitor)
[![Docker Repository on Quay](https://quay.io/repository/deisci/monitor/status "Docker Repository on Quay")](https://quay.io/repository/deisci/monitor)

Deis (pronounced DAY-iss) is an open source PaaS that makes it easy to deploy and manage applications on your own servers. Deis builds on [Kubernetes][k8s-home] to provide a lightweight, easy and secure way to deploy your code to production.

For more information about the Deis workflow, please visit the main project page at https://github.com/deis/workflow.

## Beta Status

This Deis component is currently in beta status, and we welcome your input! If you have feedback, please submit an [issue][issues]. If you'd like to participate in development, please read the "Development" section below and submit a [pull request][prs].


# About
This repository aims to contain all the necessary components for a production quality monitoring solution that runs on top of the kubernetes cluster scheduler. It provides the [TICK](https://influxdata.com/time-series-platform/) stack which is produced by the influxdata team.

## Current State
Currently this repo provides only 2 components (influxdb and telegraf). Telegraf is the metrics collection agent that runs using the daemon set API. For more infomation please read [this](telegraf/README.md).

Also provided is an influxdb container which only runs 1 instance of the database. It also does not write any data to the host filesystem so it is not a durable system right now. For more information please read [this](influxdb/README.md)

## License
Copyright 2013, 2014, 2015, 2016 Engine Yard, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[k8s-home]: http://kubernetes.io/
[issues]: https://github.com/deis/monitor/issues
[prs]: https://github.com/deis/monitor/pulls