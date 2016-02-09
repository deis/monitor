# Set Tag Configuration
[tags]

# Set Agent Configuration
[agent]
  interval = "{{ default .AGENT_INTERVAL "10s"}}"
  round_interval = {{ default .AGENT_ROUND_INTERVAL "true" }}
  metric_buffer_limit = {{ default .AGENT_BUFFER_LIMIT 10000 }}
  collection_jitter = "{{ default .AGENT_COLLECTION_JITTER "0s" }}"
  flush_interval = "{{ default .AGENT_FLUSH_INTERVAL "10s" }}"
  flush_jitter = "{{ default .AGENT_FLUSH_JITTER "0s" }}"
  debug = {{ default .AGENT_DEBUG "false" }}
  quiet = {{ default .AGENT_QUIET "false" }}
  {{if .AGENT_HOSTNAME}} hostname = {{.AGENT_HOSTNAME}} {{end}}

# Set output configuration
{{if .AMON_INSTANCE}}
[[outputs.amon]]
  server_key = "{{.AMON_SERVER_KEY}}"
  amon_instance = "{{.AMON_INSTANCE}}"
  timeout = "{{ default .AMON_TIMEOUT "5s" }}"
{{end}}

{{if .AMQP_URL}}
[[outputs.amqp]]
  url = "{{.AMQP_URL}}"
  exchange = "{{ default .AMQP_EXCHANGE "telegraf" }}"
  routing_tag = "{{default .AMQP_ROUTING_TAG "host" }}"
  {{if .AMQP_SSL_CA}} ssl_ca = "{{.AMQP_SSL_CA}}" {{end}}
  {{if .AMQP_SSL_CERT}} ssl_cert = "{{.AMQP_SSL_CERT}}" {{end}}
  {{if .AMQP_SSL_KEY}} ssl_key = "{{.AMQP_SSL_KEY}}" {{end}}
  retention_policy = "{{ default .AMQP_RETENTION_POLICY "default" }}"
  database = = "{{ default .AMQP_DATABASE "telegraf" }}"
  precision = "{{ default .AMQP_PRECISION "s" }}"
{{end}}

{{if .DATADOG_API_KEY}}
[[outputs.datadog]]
  apikey = "{{.DATADOG_API_KEY}}"
{{end}}

{{if .GRAPHITE_SERVERS}}
[[outputs.graphite]]
  servers = [{{.GRAPHITE_SERVERS}}]
  prefix = "{{default .GRAPHITE_PREFIX "\"\"" }}"
  timeout = {{default .GRAPHITE_TIMEOUT 2 }}
{{end}}

{{if .INFLUXDB_URLS}}
[[outputs.influxdb]]
  urls = ["{{.INFLUXDB_URLS}}"]
  database = "{{default .INFLUXDB_DATABASE "telegraf" }}"
  precision = "{{ default .INFLUXDB_PRECISION "s"}}"
  timeout = "{{ default .INFLUXDB_TIMEOUT "5s"}}"
  {{if .INFLUXDB_USERNAME}} username = {{.INFLUXDB_USERNAME}} {{end}}
  {{if .INFLUXDB_PASSWORD}} password = {{.INFLUXDB_PASSWORD}} {{end}}
  {{if .INFLUXDB_USER_AGENT}} user_agent = {{.INFLUXDB_USER_AGENT}} {{end}}
  {{if .INFLUXDB_UDP_PAYLOAD}} udp_payload = {{.INFLUXDB_UDP_PAYLOAD}} {{end}}
{{end}}

{{if .KAFKA_BROKERS}}
[[outputs.kafka]]
  brokers = [{{.KAFKA_BROKERS}}]
  topic = "{{ default .KAFKA_TOPIC "telegraf" }}"
  routing_tag = "{{.KAFKA_ROUTING_TAG}}"
  certificate = "{{.KAFKA_CERTIFICATE}}"
  key = "{{.KAFKA_KEY}}"
  ca = "{{.KAFKA_CA}}"
  verify_ssl = {{.KAFKA_VERIFY_SSL}}
{{end}}

{{if .LIBRATO_API_TOKEN}}
[[outputs.librato]]
  api_user = "{{.LIBRATO_API_USER}}"
  api_token = "{{.LIBRATO_API_TOKEN}}"
  source_tag = "{{.LIBRATO_SOURCE_TAG}}"
{{end}}

{{if .NSQ_SERVER}}
[[outputs.nsq]]
  server = "{{.NSQ_SERVER}}"
  topic = "{{.NSQ_TOPIC}}"
{{end}}

{{if .OPEN_TSDB_HOST}}
  prefix = "{{.OPEN_TSDB_PREFIX}}"
  host = "{{.OPEN_TSDB_HOST}}"
  port = {{.OPEN_TSDB_PORT}}
  debug = {{.OPEN_TSDB_DEUBG}}
{{end}}

{{if .RIEMANN_URL}}
[[outputs.riemann]]
  url = "{{.RIEMANN_URL}}"
  transport = "{{.RIEMANN_TRANSPORT}}"
{{end}}

# Set Input Configuration
[[inputs.netstat]]
[[inputs.swap]]
[[inputs.system]]
[[inputs.mem]]
[[inputs.cpu]]
  percpu = true
  totalcpu = true
  drop = ["time_*"]

{{if .ENABLE_ZFS}}[[inputs.zfs]]{{end}}

[[inputs.disk]]
  {{if .DISK_MOUNT_POINTS}} mount_points = [{{.DISK_MOUNT_POINTS}}] {{end}}


[[inputs.diskio]]
  {{if .DISKIO_DEVICES}} devices = {{.DISKIO_DEVICES}} {{end}}
  {{if .DISKIO_SKIP_SERIAL_NUMBER}} skip_serial_number = {{.DISKIO_SKIP_SERIAL_NUMBER}} {{end}}

[[inputs.net]]
  {{if .NET_INTERFACES}} = {{.NET_INTERFACES}} {{end}}


{{if .APACHE_URLS}}
[[inputs.apache]]
  servers = [{{.APACHE_URLS}}]
{{end}}

{{if .DISQUE_SERVERS}}
[[inputs.disque]]
  servers = [{{.DISQUE_SERVERS}}]
{{end}}

{{if .DOCKER_ENDPOINT}}
[[inputs.docker]]
  endpoint = "{{.DOCKER_ENDPOINT}}"
  container_names = [{{if .DOCKER_CONTAINER_NAMES}}{{.DOCKER_CONTAINER_NAMES}}{{end}}]
{{end}}

{{if .KUBERNETES_SERVICE_HOST}}
[[inputs.kubernetes]]
  docker_endpoint = "{{.KUBERNETES_DOCKER_ENDPOINT}}"
  container_names = [{{if .KUBERNETES_CONTAINER_NAMES}}{{.KUBERNETES_CONTAINER_NAMES}}{{end}}]
{{end}}

{{if .ELASTIC_SEARCH_SERVERS}}
[[inputs.elasticsearch]]
  servers = [{{.ELASTIC_SEARCH_SERVERS}}]
  local = {{.ELASTIC_SEARCH_LOCAL}}
  cluster_health = {{.ELASTIC_SEARCH_CLUSTER_HEALTH}}
{{end}}

{{if .HAPROXY_SERVERS}}
[[inputs.haproxy]]
  servers = [{{.HAPROXY_SERVERS}}]
{{end}}

{{if .HTTP_JSON_SERVERS}}
[[inputs.httpjson]]
  name = "{{.HTTP_JSON_NAME}}"
  servers = [{{.HTTP_JSON_SERVERS}}]
  method = "{{.HTTP_JSON_METHOD}}"
  tag_keys = [{{.HTTP_JSON_TAG_KEYS}}]
  [inputs.httpjson.parameters]
    event_type = "{{.HTTP_JSON_EVENT_TYPE}}"
    threshold = "{{.HTTP_JSON_THRESHOLD}}"
{{end}}

{{if .INFLUXDB_URLS}}
[[inputs.influxdb]]
  urls = ["{{.INFLUXDB_URLS}}/debug/vars"]
{{end}}

{{if .MEMCACHED_SERVERS}}
[[inputs.memcached]]
  servers = [{{.MEMCACHED_SERVERS}}]
{{end}}

{{if .MONGODB_SERVERS}}
[[inputs.mongodb]]
  servers = [{{.MONGODB_SERVERS}}]
{{end}}

{{if .MYSQL_SERVERS}}
[[inputs.mysql]]
  servers = [{{.MYSQL_SERVERS}}]
{{end}}

{{if .NGINX_URLS}}
[[inputs.nginx]]
  urls = [{{.NGINX_URLS}}]
{{end}}

{{if .NSQ_ENDPOINTS}}
[[inputs.nsq]]
  endpoints = [{{.NSQ_ENDPOINTS}}]
{{end}}

{{if .POSTGRESQL_ADDRESS}}
[[inputs.postgresql]]
  address = "{{.POSTGRESQL_ADDRESS}}"
  {{if .POSTGRESQL_DATABASES}} databases = [{{.POSTGRESQL_DATABASES}}]  {{end}}
{{end}}

{{if .RABBITMQ_URL}}
[[inputs.rabbitmq]]
  url = "{{.RABBITMQ_URL}}"
  {{if .RABBITMQ_NAME}} name = "{{.RABBITMQ_NAME}}" {{end}}
  {{if .RABBITMQ_USERNAME}} username = "{{.RABBITMQ_USERNAME}}" {{end}}
  {{if .RABBITMQ_PASSWORD}} password = "{{.RABBITMQ_PASSWORD}}" {{end}}
  {{if .RABBITMQ_NODES}} nodes = [{{.RABBITMQ_NODES}}] {{end}}
{{end}}

{{if .REDIS_SERVERS}}
[[inputs.redis]]
  servers = [{{.REDIS_SERVERS}}]
{{end}}

{{if .RETHINKDB_SERVERS}}
[[inputs.rethinkdb]]
  servers = [{{.RETHINKDB_SERVERS}}]
{{end}}

{{if .ZOOKEEPER_SERVERS}}
[[inputs.zookeeper]]
  servers = [{{.ZOOKEEPER_SERVERS}}]
{{end}}

# Set Service Input Configuration
{{if .KAFKA_CONSUMER_TOPICS}}
[[inputs.kafka_consumer]]
  topics = [{{.KAFKA_CONSUMER_TOPICS}}]
  zookeeper_peers = [{{.KAFKA_CONSUMER_ZOOKEEPER_PEERS}}]
  consumer_group = "{{.KAFKA_CONSUMER_GROUP}}"
  point_buffer = {{.KAFKA_CONSUMER_POINT_BUFFER}}
  offset = "{{.KAFKA_CONSUMER_OFFSET}}"
{{end}}

{{if .STATSD_SERVICE_ADDRESS}}
[[inputs.statsd]]
  service_address = "{{.STATSD_SERVICE_ADDRESS}}"
  delete_gauges = {{ default .STATSD_DELETE_GAUGES "false" }}
  delete_counters {{ default .STATSD_DELETE_COUNTERS "false" }}
  delete_sets = {{ default .STATSD_DELETE_SETS "false" }}
  delete_timings = {{ default .STATSD_DELETE_TIMINGS "true"}}
  percentiles = [{{ default .STATSD_PERCENTILES 90 }}]
  convert_names = {{ default .STATSD_CONVERT_NAMES "true" }}
  {{if .STATSD_TEMPLATES}} templates = [{{.STATSD_TEMPLATES}}] {{end}}
  allowed_pending_messages = {{ default .STATSD_ALLOWED_PENDING_MESSAGES 10000 }}
  percentile_limit = {{ default .STATSD_PERCENTILE_LIMIT 1000 }}
  udp_packet_size = {{ default .STATSD_UDP_PACKET_SIZE 1500}}
{{end}}