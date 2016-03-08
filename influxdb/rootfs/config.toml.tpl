reporting-disabled = {{ default false .REPORTING_DISABLED }}
dir = {{ default "" .DIR | quote }}
bind-address = {{ default ":8088" .BIND_ADDRESS | quote }}

[meta]
  enabled = {{ default true .META_ENABLED }}
  dir = {{ default "/data/meta" .META_DIR | quote }}
  bind-address = {{ default ":8088" .META_BIND_ADDRESS | quote }}
  http-bind-address = {{ default ":8091" .META_HTTP_BIND_ADDRESS | quote }}
  https-enabled = {{ default false .META_HTTPS_ENABLED }}
  https-certificate = {{ default "" .META_HTTPS_CERTIFICATE | quote }}
  retention-autocreate = {{ default true .META_RETENTION_AUTOCREATE }}
  election-timeout = {{ default "1s" .META_ELECTION_TIMEOUT | quote }}
  heartbeat-timeout = {{ default "1s" .META_HEARTBEAT_TIMEOUT | quote }}
  leader-lease-timeout = {{ default "500ms" .META_LEADER_LEASE_TIMEOUT | quote }}
  commit-timeout = {{ default "50ms" .META_COMMIT_TIMEOUT | quote }}
  cluster-tracing = {{ default false .META_CLUSTER_TRACING }}
  raft-promotion-enabled = {{ default true .META_RAFT_PROMOTION_ENABLED }}
  logging-enabled = {{ default false .META_LOGGING.ENABLED }}
  pprof-enabled = {{ default false .META_PPROF_ENABLED }}
  lease-duration = {{ default "1m0s" .META_LEASE_DURATION | quote }}

[data]
  enabled = {{ default true .DATA_ENABLED }}
  dir = {{ default "/data/db" .DATA_DIR | quote }}
  engine = {{ default "tsm1" .DATA_ENGINE | quote }}
  max-wal-size = {{ default 104857600 .DATA_MAX_WAL_SIZE }}
  wal-flush-interval = {{ default "10m0s" .DATA_WAL_FLUSH_INTERVAL | quote }}
  wal-partition-flush-delay = {{ default "2s" .DATA_WAL_PARTITION_FLUSH_DELAY | quote }}
  wal-dir = {{ default "/data/db/wal" .DATA_WAL_DIR | quote }}
  wal-logging-enabled = {{ default true .DATA_WAL_LOGGING_ENABLED }}
  wal-ready-series-size = {{ default 30720 .DATA_WAL_READY_SERIES_SIZE }}
  wal-compaction-threshold = {{ default 0.5 .DATA_WAL_COMPACTION_THRESHOLD }}
  wal-max-series-size = {{ default 1048576 .DATA_WAL_MAX_SERIES_SIZE }}
  wal-flush-cold-interval = {{ default "5s" .DATA_WAL_FLUSH_COLD_INTERVAL | quote }}
  wal-partition-size-threshold = {{ default 52428800 .DATA_WAL_PARTITION_SIZE_THRESHOLD }}
  query-log-enabled = {{ default true .DATA_QUERY_LOG_ENABLED }}
  cache-max-memory-size = {{ default 524288000 .DATA_CACHE_MAX_MEMORY_SIZE }}
  cache-snapshot-memory-size = {{ default 26214400 .DATA_CACHE_SNAPSHOT_MEMORY_SIZE }}
  cache-snapshot-write-cold-duration = {{ default "1h0m0s" .DATA_CACHE_SNAPSHOT_WRITE_COLD_DURATION | quote }}
  compact-full-write-cold-duration = {{ default "24h0m0s" .DATA_COMPACT_FULL_WRITE_COLD_DURATION | quote }}
  max-points-per-block = {{ default 0 .DATA_MAX_POINTS_PER_BLOCK }}
  data-logging-enabled = {{ default true .DATA_LOGGING_ENABLED }}

[cluster]
  force-remote-mapping = {{ default false .CLUSTER_FORCE_REMOTE_MAPPING }}
  write-timeout = {{ default "5s" .CLUSTER_WRITE_TIMEOUT | quote }}
  shard-writer-timeout = {{ default "5s" .CLUSTER_SHARD_WRITER_TIMEOUT | quote }}
  shard-mapper-timeout = {{ default "5s" .CLUSTER_SHARD_MAPPER_TIMEOUT | quote }}

[retention]
  enabled = {{ default true .RETENTION_ENABLED }}
  check-interval = {{ default "30m0s" .CHECK_INTERVAL | quote }}

[shard-precreation]
  enabled = {{ default true .SHARD_PRECREATION_ENABLED }}
  check-interval = {{ default "10m0s" .SHARD_PRECREATION_CHECK_INTERVAL | quote }}
  advance-period = {{ default "30m0s" .SHARD_PRECREATION_ADVANCE_PERIOD | quote }}

[admin]
  enabled = {{ default true .ADMIN_ENABLED }}
  bind-address = {{ default ":8083" .ADMIN_BIND_ADDRESS | quote }}
  https-enabled = {{ default false .ADMIN_HTTPS_ENABLED }}
  https-certificate = {{ default "/etc/ssl/influxdb.pem" .ADMIN_HTTPS_CERTIFICATE | quote }}

[monitor]
  store-enabled = {{ default true .MONITOR_STORE_ENABLED }}
  store-database = {{ default "_internal" .MONITOR_STORE_DATABASE | quote }}
  store-interval = {{ default "10s" .MONITOR_STORE_INTERVAL | quote }}

[subscriber]
  enabled = {{ default true .SUBSCRIBER_ENABLED }}

[http]
  enabled = {{ default true .HTTP_ENABLED }}
  bind-address = {{ default ":8086" .HTTP_BIND_ADDRESS | quote }}
  auth-enabled = {{ default false .HTTP_AUTH_ENABLED }}
  log-enabled = {{ default true .HTTP_LOG_ENABLED }}
  write-tracing = {{ default false .HTTP_WRITE_TRACING }}
  pprof-enabled = {{ default false .HTTP_PPROF_ENABLED }}
  https-enabled = {{ default false .HTTP_HTTPS_ENABLED }}
  https-certificate = {{ default "/etc/ssl/influxdb.pem" .HTTP_HTTPS_CERTIFICATE | quote }}


[continuous_queries]
  log-enabled = {{ default true .CONTINUOUS_QUERIES_LOG_ENABLED }}
  enabled = {{ default true .CONTINUOUS_QUERIES_ENABLED }}
  run-interval = {{ default "1s" .CONTINUOUS_QUERIES_RUN_INTERVAL | quote }}

[hinted-handoff]
  enabled = {{ default true .HINTED_HANDOFF_ENABLED}}
  dir = {{ default "/home/influxdb/.influxdb/hh" .HINTED_HANDOFF_DIR | quote }}
  max-size = {{ default 1073741824 .HINTED_HANDOFF_MAX_SIZE }}
  max-age = {{ default "168h0m0s" .HINTED_HANDOFF_MAX_AGE | quote }}
  retry-rate-limit = {{ default 0 .HINTED_HANDOFF_RETRY_RATE_LIMIT }}
  retry-interval = {{ default "1s" .HINTED_HANDOFF_RETRY_INTERVAL | quote }}
  retry-max-interval = {{ default "1m0s" .HINTED_HANDOFF_RETRY_MAX_INTERVAL | quote }}
  purge-interval = {{ default "1h0m0s" .HINTED_HANDOFF_PURGE_INTERVAL | quote }}
