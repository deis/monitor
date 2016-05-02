# Set Tag Configuration
[tags]

{{ if .GLOBAL_TAGS }}
[global_tags]
  {{ range $index, $item := split "," .GLOBAL_TAGS }}
    {{ $value := split ":" $item }}{{ $value._0 }}={{ $value._1 | quote }}
  {{end}}
{{ end }}

# Set Agent Configuration
[agent]
  interval = {{ default "10s" .AGENT_INTERVAL | quote }}
  round_interval = {{ default true .AGENT_ROUND_INTERVAL }}
  metric_buffer_limit = {{ default "10000" .AGENT_BUFFER_LIMIT }}
  collection_jitter = {{ default "0s" .AGENT_COLLECTION_JITTER | quote }}
  flush_interval = {{ default "10s" .AGENT_FLUSH_INTERVAL | quote }}
  flush_jitter = {{ default "0s" .AGENT_FLUSH_JITTER | quote }}
  debug = {{ default false .AGENT_DEBUG }}
  quiet = {{ default false .AGENT_QUIET }}
  flush_buffer_when_full = {{ default true .AGENT_FLUSH_BUFFER }}
  {{ if .AGENT_HOSTNAME }}hostname = {{ .AGENT_HOSTNAME | quote }} {{ end }}

# Set output configuration
{{ if .AMON_INSTANCE }}
[[outputs.amon]]
  server_key = {{ .AMON_SERVER_KEY | quote }}
  amon_instance = {{ .AMON_INSTANCE | quote }}
  timeout = {{ default "5s" .AMON_TIMEOUT | quote }}
{{ end }}

{{ if .AMQP_URL }}
[[outputs.amqp]]
  url = {{ .AMQP_URL | quote }}
  exchange = {{ default "telegraf" .AMQP_EXCHANGE | quote }}
  routing_tag = {{ default "host" .AMQP_ROUTING_TAG | quote }}
  {{ if .AMQP_SSL_CA }} ssl_ca = {{ .AMQP_SSL_CA | quote }} {{ end }}
  {{ if .AMQP_SSL_CERT }} ssl_cert = {{ .AMQP_SSL_CERT | quote }} {{ end }}
  {{ if .AMQP_SSL_KEY }} ssl_key = {{ .AMQP_SSL_KEY | quote }} {{ end }}
  retention_policy = {{ default "default" .AMQP_RETENTION_POLICY | quote }}
  database = = {{ default "telegraf" .AMQP_DATABASE | quote }}
  precision = {{ default "s" .AMQP_PRECISION | quote }}
{{ end }}

{{ if .DATADOG_API_KEY }}
[[outputs.datadog]]
  apikey = {{ .DATADOG_API_KEY | quote }}
{{ end }}

{{ if .GRAPHITE_SERVERS }}
[[outputs.graphite]]
  servers = [{{ .GRAPHITE_SERVERS }}]
  prefix = {{ default "" .GRAPHITE_PREFIX | quote }}
  timeout = {{ default 2 .GRAPHITE_TIMEOUT }}
{{ end }}

{{ if .INFLUXDB_URLS}}
[[outputs.influxdb]]
  urls = [{{ .INFLUXDB_URLS | quote }}]
  database = {{default "telegraf" .INFLUXDB_DATABASE | quote }}
  precision = {{ default "s" .INFLUXDB_PRECISION | quote }}
  timeout = {{ default "5s" .INFLUXDB_TIMEOUT | quote }}
  {{ if .INFLUXDB_USERNAME}} username = {{ .INFLUXDB_USERNAME | quote }} {{ end }}
  {{ if .INFLUXDB_PASSWORD}} password = {{ .INFLUXDB_PASSWORD | quote }} {{ end }}
  {{ if .INFLUXDB_USER_AGENT}} user_agent = {{ .INFLUXDB_USER_AGENT | quote }} {{ end }}
  {{ if .INFLUXDB_UDP_PAYLOAD}} udp_payload = {{ .INFLUXDB_UDP_PAYLOAD | quote }} {{ end }}
{{ end }}

{{ if .KAFKA_BROKERS}}
[[outputs.kafka]]
  brokers = [{{ .KAFKA_BROKERS | quote }}]
  topic = {{ default "telegraf" .KAFKA_TOPIC | quote }}
  routing_tag = {{ .KAFKA_ROUTING_TAG | quote }}
  {{ if .KAFKA_CERTIFICATE }} certificate = {{ .KAFKA_CERTIFICATE | quote }} {{ end }}
  {{ if .KAFKA_KEY }} key = {{ .KAFKA_KEY | quote }} {{ end }}
  {{ if .KAFKA_CA }} ca = {{ .KAFKA_CA | quote }} {{ end }}
  {{ if .KAFKA_VERIFY_SSL }} verify_ssl = {{ .KAFKA_VERIFY_SSL }} {{ end }}
{{ end }}

{{ if .LIBRATO_API_TOKEN }}
[[outputs.librato]]
  api_user = {{ .LIBRATO_API_USER | quote }}
  api_token = {{ .LIBRATO_API_TOKEN | quote }}
  source_tag = {{ .LIBRATO_SOURCE_TAG | quote }}
{{ end }}

{{ if .NSQ_SERVER }}
[[outputs.nsq]]
  server = {{ .NSQ_SERVER | quote }}
  topic = {{ .NSQ_TOPIC | quote }}
{{ end }}

{{ if .OPEN_TSDB_HOST }}
  prefix = {{ .OPEN_TSDB_PREFIX | quote }}
  host = {{ .OPEN_TSDB_HOST | quote }}
  port = {{ .OPEN_TSDB_PORT }}
  debug = {{ .OPEN_TSDB_DEUBG }}
{{ end }}

{{ if .RIEMANN_URL }}
[[outputs.riemann]]
  url = {{ .RIEMANN_URL | quote }}
  transport = {{ .RIEMANN_TRANSPORT | quote }}
{{ end }}

# Set Input Configuration
[[inputs.netstat]]
[[inputs.swap]]
[[inputs.system]]
[[inputs.mem]]
[[inputs.cpu]]
  percpu = true
  totalcpu = true

{{ if .ENABLE_ZFS }}[[inputs.zfs]]{{ end }}

[[inputs.disk]]
  {{ if .DISK_MOUNT_POINTS }} mount_points = [{{ .DISK_MOUNT_POINTS }}] {{ end }}


[[inputs.diskio]]
  {{ if .DISKIO_DEVICES }} devices = [{{ .DISKIO_DEVICES }}] {{ end }}
  {{ if .DISKIO_SKIP_SERIAL_NUMBER }} skip_serial_number = {{ .DISKIO_SKIP_SERIAL_NUMBER }} {{ end }}

[[inputs.net]]
  {{ if .NET_INTERFACES }} interfaces = [{{ .NET_INTERFACES}}] {{ end }}


{{ if .APACHE_URLS }}
[[inputs.apache]]
  servers = [{{ .APACHE_URLS }}]
{{ end }}

{{ if .DISQUE_SERVERS }}
[[inputs.disque]]
  servers = [{{ .DISQUE_SERVERS }}]
{{ end }}

{{ if .DOCKER_ENDPOINT }}
[[inputs.docker]]
  endpoint = {{ .DOCKER_ENDPOINT | quote }}
  container_names = [{{ if .DOCKER_CONTAINER_NAMES }}{{ .DOCKER_CONTAINER_NAMES }}{{ end }}]
{{ end }}

{{ if .ELASTIC_SEARCH_SERVERS }}
[[inputs.elasticsearch]]
  servers = [{{ .ELASTIC_SEARCH_SERVERS }}]
  local = {{ .ELASTIC_SEARCH_LOCAL }}
  cluster_health = {{ .ELASTIC_SEARCH_CLUSTER_HEALTH }}
{{ end }}

{{ if .HAPROXY_SERVERS }}
[[inputs.haproxy]]
  servers = [{{ .HAPROXY_SERVERS }}]
{{ end }}

{{ if .HTTP_JSON_SERVERS }}
[[inputs.httpjson]]
  name = {{ .HTTP_JSON_NAME | quote }}
  servers = [{{ .HTTP_JSON_SERVERS }}]
  method = {{ .HTTP_JSON_METHOD | quote }}
  tag_keys = [{{ .HTTP_JSON_TAG_KEYS }}]
  [json.parameters]
    event_type = {{ .HTTP_JSON_EVENT_TYPE | quote }}
    threshold = {{ .HTTP_JSON_THRESHOLD | quote }}
{{end}}

{{ if .INFLUXDB_URLS }}
[[inputs.influxdb]]
  urls = [{{ (print .INFLUXDB_URLS "/debug/vars") | quote }}]
{{ end }}

{{ if .MEMCACHED_SERVERS }}
[[inputs.memcached]]
  servers = [{{ .MEMCACHED_SERVERS }}]
{{ end }}

{{ if .MONGODB_SERVERS }}
[[inputs.mongodb]]
  servers = [{{ .MONGODB_SERVERS }}]
{{ end }}

{{ if .MYSQL_SERVERS }}
[[inputs.mysql]]
  servers = [{{ .MYSQL_SERVERS }}]
{{ end }}

{{ if .NGINX_URLS }}
[[inputs.nginx]]
  urls = [{{ .NGINX_URLS }}]
{{ end }}

{{ if .NSQ_ENDPOINTS }}
[[inputs.nsq]]
  endpoints = [{{ .NSQ_ENDPOINTS }}]
{{ end }}

{{ if .POSTGRESQL_ADDRESS }}
[[inputs.postgresql]]
  address = {{ .POSTGRESQL_ADDRESS | quote }}
  {{ if .POSTGRESQL_DATABASES }} databases = [{{ .POSTGRESQL_DATABASES }}]  {{ end }}
{{ end }}

{{ if .PROMETHEUS_URLS }}
[[inputs.prometheus]]
  urls = [{{ .PROMETHEUS_URLS }}]
  insecure_skip_verify = {{ default true .PROMETHEUS_INSECURE_SKIP_VERIFY }}
  bearer_token = {{ .PROMETHEUS_BEARER_TOKEN | quote }}
{{ end }}

{{ if .RABBITMQ_URL }}
[[inputs.rabbitmq]]
  url = {{ .RABBITMQ_URL | quote }}
  {{ if .RABBITMQ_NAME}} name = {{ .RABBITMQ_NAME | quote }} {{ end }}
  {{ if .RABBITMQ_USERNAME }} username = {{ .RABBITMQ_USERNAME | quote }} {{ end }}
  {{ if .RABBITMQ_PASSWORD }} password = {{ .RABBITMQ_PASSWORD | quote }} {{ end }}
  {{ if .RABBITMQ_NODES }} nodes = [{{ .RABBITMQ_NODES}}] {{ end }}
{{ end }}

{{ if .REDIS_SERVERS }}
[[inputs.redis]]
  servers = [{{ .REDIS_SERVERS }}]
{{ end }}

{{ if .RETHINKDB_SERVERS }}
[[inputs.rethinkdb]]
  servers = [{{ .RETHINKDB_SERVERS }}]
{{ end }}

{{ if .ZOOKEEPER_SERVERS }}
[[inputs.zookeeper]]
  servers = [{{ .ZOOKEEPER_SERVERS }}]
{{ end }}

# Set Service Input Configuration
{{ if .KAFKA_CONSUMER_TOPICS }}
[[inputs.kafka_consumer]]
  topics = [{{ .KAFKA_CONSUMER_TOPICS }}]
  zookeeper_peers = [{{ .KAFKA_CONSUMER_ZOOKEEPER_PEERS }}]
  consumer_group = {{ .KAFKA_CONSUMER_GROUP | quote }}
  point_buffer = {{ .KAFKA_CONSUMER_POINT_BUFFER }}
  offset = {{ .KAFKA_CONSUMER_OFFSET | quote }}
{{ end }}

{{ if .STATSD_SERVICE_ADDRESS }}
[[inputs.statsd]]
  service_address = {{ .STATSD_SERVICE_ADDRESS | quote }}
  delete_gauges = {{ default false .STATSD_DELETE_GAUGES }}
  delete_counters = {{ default false .STATSD_DELETE_COUNTERS }}
  delete_sets = {{ default false .STATSD_DELETE_SETS }}
  delete_timings = {{ default true .STATSD_DELETE_TIMINGS}}
  percentiles = [{{ default 90 .STATSD_PERCENTILES }}]
  convert_names = {{ default true .STATSD_CONVERT_NAMES }}
  {{ if .STATSD_TEMPLATES}} templates = [{{ .STATSD_TEMPLATES }}] {{ end }}
  allowed_pending_messages = {{ default 10000 .STATSD_ALLOWED_PENDING_MESSAGES }}
  percentile_limit = {{ default 1000 .STATSD_PERCENTILE_LIMIT }}
  udp_packet_size = {{ default 1500 .STATSD_UDP_PACKET_SIZE }}
{{ end }}
