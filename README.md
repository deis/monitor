
|![](https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/Warning.svg/156px-Warning.svg.png) | Deis Workflow is no longer maintained.<br />Please [read the announcement](https://deis.com/blog/2017/deis-workflow-final-release/) for more detail. |
|---:|---|
| 09/07/2017 | Deis Workflow [v2.18][] final release before entering maintenance mode |
| 03/01/2018 | End of Workflow maintenance: critical patches no longer merged |
| | [Hephy](https://github.com/teamhephy/workflow) is a fork of Workflow that is actively developed and accepts code contributions. |

# Deis Monitor v2
[![Build Status](https://ci.deis.io/job/monitor/badge/icon)](https://ci.deis.io/job/monitor)
[![Docker Repository on Quay](https://quay.io/repository/deisci/grafana/status "Docker Repository on Quay")](https://quay.io/repository/deisci/grafana)
[![Docker Repository on Quay](https://quay.io/repository/deisci/influxdb/status "Docker Repository on Quay")](https://quay.io/repository/deisci/influxdb)
[![Docker Repository on Quay](https://quay.io/repository/deisci/telegraf/status "Docker Repository on Quay")](https://quay.io/repository/deisci/telegraf)

Deis (pronounced DAY-iss) Workflow is an open source Platform as a Service (PaaS) that adds a developer-friendly layer to any [Kubernetes](http://kubernetes.io) cluster, making it easy to deploy and manage applications on your own servers.

For more information about the Deis Workflow, please visit the main project page at https://github.com/deis/workflow.

We welcome your input! If you have feedback, please [submit an issue][issues]. If you'd like to participate in development, please read the "Development" section below and [submit a pull request][prs].

# About
This repository aims to contain all the necessary components for a production quality monitoring solution that runs on top of the kubernetes cluster scheduler. It provides part of the [TICK](https://influxdata.com/time-series-platform/) stack which is produced by the influxdata team.

## Current State
Currently this repo provides only 3 components (Influxdb, Telegraf, and Grafana). Telegraf is the metrics collection agent that runs using the daemon set API. For more infomation please read [this](telegraf/README.md).

Also provided is an Influxdb container which only runs 1 instance of the database. It also does not write any data to the host filesystem so it is not a durable system right now. For more information please read [this](influxdb/README.md)

Lastly, Grafana is a stand alone graphing application. It natively supports Influxdb as a datasource and provides a robust engine for creating dashboards on top of timeseries data. We provide a few out of the box dashboards for monitoring Deis Workflow and Kubernetes but please feel free to use them as a starting point for creating your own dashboards.

# Architecture Diagram

```
                        ┌────────┐
                        │ Router │                  ┌────────┐
                        └────────┘                  │ Logger │
                            │                       └────────┘
                        Log file                        │
                            │                           │
                            ▼                           ▼
┌────────┐             ┌─────────┐    logs/metrics   ┌─────┐
│App Logs│──Log File──▶│ fluentd │───────topics─────▶│ NSQ │
└────────┘             └─────────┘                   └─────┘
                                                        │
                                                        │
┌─────────────┐                                         │
│ HOST        │                                         ▼
│  Telegraf   │───┐                                ┌────────┐
└─────────────┘   │                                │Telegraf│
                  │                                └────────┘
┌─────────────┐   │                                    │
│ HOST        │   │    ┌───────────┐                   │
│  Telegraf   │───┼───▶│ InfluxDB  │◀────Wire ─────────┘
└─────────────┘   │    └───────────┘   Protocol
                  │          ▲
┌─────────────┐   │          │
│ HOST        │   │          ▼
│  Telegraf   │───┘    ┌──────────┐
└─────────────┘        │ Grafana  │
                       └──────────┘
```

[k8s-home]: http://kubernetes.io/
[issues]: https://github.com/deis/monitor/issues
[prs]: https://github.com/deis/monitor/pulls
[v2.18]: https://github.com/deis/workflow/releases/tag/v2.18.0

