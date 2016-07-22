#################### Grafana Configuration Example #####################
#
# Everything has defaults so you only need to uncomment things you want to
# change

# possible values : production, development
app_mode = {{ default "development" .APP_MODE }}

#################################### Paths ####################################
[paths]
# Path to where grafana can store temp files, sessions, and the sqlite3 db (if that is used)
#
data = {{ default "/var/lib/grafana" .DATA_PATH }}

#
# Directory where grafana can store logs
#
logs = {{ default "/var/log" .LOG_PATH }}

#################################### Server ####################################
[server]
# Protocol (http or https)
protocol = {{ default "http" .SERVER_PROTOCOL }}

# The ip address to bind to, empty will bind to all interfaces
http_addr = {{ default "" .BIND_ADDRESS}}
# The http port to use
http_port = {{ default "3000" .BIND_PORT }}

# The public facing domain name used to access grafana from a browser
domain = {{ default "localhost" .DOMAIN }}

# Redirect to correct domain if host header does not match domain
# Prevents DNS rebinding attacks
enforce_domain = {{ default "false" .ENFORCE_DOMAIN }}

# The full public facing url
root_url = {{ default "%(protocol)s://%(domain)s:%(http_port)s/" .ROOT_URL }}

# Log web requests
router_logging = {{ default "false" .ROUTER_LOGGING }}

# the path relative working path
static_root_path = {{ default "public" .STATIC_ROOT_PATH }}

# enable gzip
enable_gzip = {{ default "false" .ENABLE_GZIP }}

# https certs & key file
{{ if .CERT_FILE }}
cert_file = {{ .CERT_FILE }}
{{ end }}
{{ if .CERT_KEY }}
cert_key = {{ .CERT_KEY }}
{{ end }}

#################################### Database ####################################
[database]
# Either "mysql", "postgres" or "sqlite3", it's your choice
{{ if .DATABASE_TYPE }}
type = {{ .DATABASE_TYPE }}
{{ end }}
{{ if .DATABASE_HOST }}
host = {{ .DATABASE_HOST }}
{{ end }}
{{ if .DATABASE_NAME }}
name = {{ .DATABASE_NAME }}
{{ end }}
{{ if .DATABASE_USER }}
user = {{ .DATABASE_USER }}
{{ end }}
{{ if .DATABASE_PASSWORD }}
password = {{ .DATABASE_PASSWORD }}
{{ end }}

# For "postgres" only, either "disable", "require" or "verify-full"
{{ if .DATABASE_SSL_MODE }}
ssl_mode = {{ .DATABASE_SSL_MODE }}
{{ end }}

# For "sqlite3" only, path relative to data_path setting
{{ if .DATABASE_PATH }}
path = {{ .DATABASE_PATH }}
{{ end }}

#################################### Session ####################################
[session]
# Either "memory", "file", "redis", "mysql", "postgres", default is "file"
provider = {{ default "file" .SESSION_PROVIDER }}

# Provider config options
# memory: not have any config yet
# file: session dir path, is relative to grafana data_path
# redis: config like redis server e.g. `addr=127.0.0.1:6379,pool_size=100,db=grafana`
# mysql: go-sql-driver/mysql dsn config string, e.g. `user:password@tcp(127.0.0.1:3306)/database_name`
# postgres: user=a password=b host=localhost port=5432 dbname=c sslmode=disable
{{ if .SESSION_PROVIDER_CONFIG }}
provider_config = {{ .SESSION_PROVIDER_CONFIG }}
{{ end }}

# Session cookie name
cookie_name = {{ default "grafana_sess" .SESSION_COOKIE_NAME }}

# If you use session in https only, default is false
cookie_secure = {{ default "false" .SESSION_COOKIE_SECURE }}

# Session life time, default is 86400
session_life_time = {{ default "86400" .SESSION_LIFE_TIME }}

#################################### Analytics ####################################
[analytics]
# Server reporting, sends usage counters to stats.grafana.org every 24 hours.
# No ip addresses are being tracked, only simple counters to track
# running instances, dashboard and error counts. It is very helpful to us.
# Change this option to false to disable reporting.
reporting_enabled = {{ default "false" .GRAFANA_REPORTING }}

# Google Analytics universal tracking code, only enabled if you specify an id here
{{ if .GOOGLE_ANALYTICS_UA_ID }}
google_analytics_ua_id = {{ .GOOGLE_ANALYTICS_UA_ID }}
{{ end }}

#################################### Security ####################################
[security]
# default admin user, created on startup
admin_user = {{ default "admin" .DEFAULT_USER }}

# default admin password, can be changed before first start of grafana,  or in profile settings
admin_password = {{ default "admin" .DEFAULT_USER_PASSWORD }}

# used for signing
secret_key = {{ default "SW2YcwTIb9zpOOhoPsMm" .SECRET_KEY }}

# Auto-login remember days
login_remember_days = {{ default "7" .LOGIN_REMEMBER_DAYS }}
cookie_username = {{ default "grafana_user" .COOKIE_USERNAME }}
cookie_remember_name = {{ default "grafana_remember" .COOKIE_REMEMBER_NAME }}

# disable gravatar profile images
disable_gravatar = {{ default "false" .DISABLE_GRAVATAR  }}

# data source proxy whitelist (ip_or_domain:port seperated by spaces)
{{ if .DATASOURCE_PROXY_WHITELIST }}
data_source_proxy_whitelist = {{ .DATA_SOURCE_PROXY_WHITELIST }}
{{ end }}

#################################### Users ####################################
[users]
# disable user signup / registration
allow_sign_up = {{ default "true" .ALLOW_SIGN_UP }}

# Allow non admin users to create organizations
allow_org_create = {{ default "true" .ALLOW_ORG_CREATE }}

# Set to true to automatically assign new users to the default organization (id 1)
auto_assign_org = {{ default "true" .AUTO_ASSIGN_ORG }}

# Default role new users will be automatically assigned (if disabled above is set to true)
auto_assign_org_role = {{ default "Viewer" .AUTO_ASSIGN_ORG_ROLE }}

# Background text for the user field on the login page
login_hint = {{ default "email or username" .LOGIN_HINT }}

#################################### Anonymous Auth ##########################
[auth.anonymous]
# enable anonymous access
enabled = {{ default "false" .ANON_ACCESS }}

# specify organization name that should be used for unauthenticated users
org_name = {{ default "Main Org." .ORG_NAME }}

# specify role for unauthenticated users
org_role = {{ default "Viewer" .UNAUTHED_USER_ORG_ROLE }}

#################################### Github Auth ##########################
[auth.github]
{{ if .GITHUB_AUTH }}
enabled = {{ .GITHUB_AUTH }}
allow_sign_up = {{ default "false" .GITHUB_AUTH_ALLOW_SIGN_UP }}
client_id = {{ .GITHUB_AUTH_CLIENT_ID }}
client_secret = {{ .GITHUB_AUTH_CLIENT_SECRET }}
scopes = {{ default "user:email,read:org" .GITHUB_AUTH_SCOPES }}
auth_url = {{ default "https://github.com/login/oauth/authorize" .GITHUB_AUTH_URL }}
token_url = {{ default "https://github.com/login/oauth/access_token" .GITHUB_AUTH_TOKEN_URL }}
api_url = {{ default "https://api.github.com/user" .GITHUB_AUTH_API_URL }}
team_ids = {{ default "" .GITHUB_AUTH_TEAM_IDS }}
allowed_organizations = {{ default "" .GITHUB_AUTH_ALLOWED_ORGS}}
{{ end }}

#################################### Google Auth ##########################
[auth.google]
{{ if .GOOGLE_AUTH }}
enabled = {{ .GOOGLE_AUTH }}
allow_sign_up = {{ default "false" .GOOGLE_AUTH_ALLOW_SIGN_UP }}
client_id = {{ .GOOGLE_AUTH_CLIENT_ID }}
client_secret = {{ .GOOGLE_AUTH_CLIENT_SECRET }}
scopes = {{ default "https://www.googleapis.com/auth/userinfo.profile ttps://www.googleapis.com/auth/userinfo.email" .GOOGLE_AUTH_SCOPES }}
auth_url = {{ default "https://accounts.google.com/o/oauth2/auth" .GOOGLE_AUTH_URL }}
token_url = {{ default "https://accounts.google.com/o/oauth2/token" .GOOGLE_AUTH_TOKEN_URL }}
api_url = {{ default "https://www.googleapis.com/oauth2/v1/userinfo" .GOOGLE_AUTH_API_URL }}
allowed_domains = {{ default "" .GOOGLE_AUTH_ALLOWED_DOMAINS }}
{{ end }}

#################################### Auth Proxy ##########################
[auth.proxy]
{{ if .AUTH_PROXY }}
enabled = {{ .AUTH_PROXY }}
header_name = {{ default "X-WEBAUTH-USER" .AUTH_HEADER_NAME" }}
header_property = {{ default "username" .AUTH_HEADER_PROPERTY }}
auto_sign_up = {{ default "true" .AUTH_AUTO_SIGN_UP }}
{{ end }}

#################################### Basic Auth ##########################
[auth.basic]
enabled = {{ default "true" .BASIC_AUTH }}

#################################### Auth LDAP ##########################
[auth.ldap]
{{ if .LDAP_AUTH }}
enabled = {{ .LDAP_AUTH }}
config_file = {{ default "/etc/grafana/ldap.toml" .LDAP_AUTH_CONFIG_FILE }}
{{ end }}

#################################### SMTP / Emailing ##########################
[smtp]
{{ if .SMTP }}
enabled = {{ .SMTP }}
host = {{ .SMTP_HOST }}
user = {{ .SMTP_USER }}
password = {{ .SMTP_PASSWORD }}
cert_file = {{ .SMTP_CERT_FILE }}
key_file = {{ .SMTP_KEY_FILE }}
skip_verify = {{ default "false" .SMTP_SKIP_VERIFY }}
from_address = {{ default "admin@grafana.localhost" .SMTP_FROM_ADDRESS }}
{{ end }}

[emails]
welcome_email_on_sign_up = {{ default "false" .WELCOME_EMAIL }}

#################################### Logging ##########################
[log]
# Either "console", "file", default is "console"
# Use comma to separate multiple modes, e.g. "console, file"
mode = {{ default "console" .LOG_MODE }}

# Buffer length of channel, keep it as it is if you don't know what it is.
buffer_len = {{ default "10000" .BUFFER_LENGTH }}

# Either "Trace", "Debug", "Info", "Warn", "Error", "Critical", default is "Trace"
level = {{ default "Info" .LOG_LEVEL }}

# For "console" mode only
[log.console]
level = {{ default "Info" .LOG_LEVEL_CONSOLE }}

# For "file" mode only
[log.file]
level = {{ default "Info" .LOG_LEVEL_FILE }}
# This enables automated log rotate(switch of following options), default is true
log_rotate = {{ default "true" .LOG_ROTATE }}

# Max line number of single file, default is 1000000
max_lines = {{ default "1000000" .LOG_MAX_LINES }}

# Max size shift of single file, default is 28 means 1 << 28, 256MB
max_lines_shift = {{ default "28" .LOG_MAX_LINES_SHIFT }}

# Segment log daily, default is true
daily_rotate = {{ default "true" .LOG_DAILY_ROTATE }}

# Expired days of log file(delete after max days), default is 7
max_days = {{ default "7" .LOG_MAX_DAYS }}

#################################### AMPQ Event Publisher ##########################
[event_publisher]
{{ if .AMQP_PUBLISHER }}
enabled = {{ .AMQP_PUBLISHER }}
rabbitmq_url = {{ .AMQP_PUBLISHER_HOST }}
exchange = {{ .AMQP_PUBLISHER_EXCHANGE }}
{{ end }}

;#################################### Dashboard JSON files ##########################
[dashboards.json]
enabled = {{ default "true" .DASHBOARD_JSON }}
path = {{ default "/usr/share/grafana/dashboards" .DASHBOARD_JSON_PATH }}
