# Grafana
[![Docker Repository on Quay](https://quay.io/repository/deisci/grafana/status "Docker Repository on Quay")](https://quay.io/repository/deisci/grafana)

## Description
[Grafana](https://grafana.org/) is a graphing application built for time series data. It natively supports influxdb and provides great dashboarding support. This project is focused on provided a grafana installation that can be run within a kubernetes installation. The grafana application is agnostic to [Workflow](https://github.com/deis/workflow) and can be installed as a stand alone system with the monitoring suite.

## Configuration
| ENV Var | Default Value | Description |
|---------|---------------|-------------|
| <a name="app_mode"></a> [APP_MODE](#app_mode) | development | Has two possible values (production or development). |
| <a name="data_path"></a> [DATA_PATH](#data_path) | /var/lib/grafana | Path to where grafana can store temp files, sessions, and the sqlite3 db (if that is used). |
| <a name="log_path"></a> [LOG_PATH](#log_path) | /var/log | Directory where grafana can store logs. |
| <a name="server_protocol"></a> [SERVER_PROTOCOL](#server_protocol) | http | Protocol (http or https). |
| <a name="bind_address"></a> [BIND_ADDRESS](#bind_address) | `""` | The ip address to bind to, empty will bind to all interfaces |
| <a name="bind_port"></a> [BIND_PORT](#bind_port) | 3000 | The http port  to use |
| <a name="domain"></a> [DOMAIN](#domain) | localhost | The public facing domain name used to access grafana from a browser |
| <a name="enforce_domain"></a> [ENFORCE_DOMAIN](#enforce_domain) | false | Redirect to correct domain if host header does not match domain. Prevents DNS rebinding attacks |
| <a name="root_url"></a> [ROOT_URL](#root_url) | `"%(protocol)s://%(domain)s:%(http_port)s/"` | The full public facing url |
| <a name="router_logging"></a> [ROUTER_LOGGING](#router_logging) | false | Log web requests |
| <a name="static_root_path"></a> [STATIC_ROOT_PATH](#static_root_path) | public | the path relative working path |
| <a name="enable_gzip"></a> [ENABLE_GZIP](#enable_gzip) | false | enable gzip |
| <a name="cert_file"></a> [CERT_FILE](#cert_file) | no default | https certs |
| <a name="cert_key"></a> [CERT_KEY](#cert_key) | no default | https certs key |
| <a name="database_type"></a> [DATABASE_TYPE](#database_type) | no default | Potential values: mysql, postgres, sqlite3 |
| <a name="database_host"></a> [DATABASE_HOST](#database_host) | no default | Address to external database host |
| <a name="database_name"></a> [DATABASE_NAME](#database_name) | no default | Name of database to store information |
| <a name="database_user"></a> [DATABASE_USER](#database_user) | no default | User to log into the database with |
| <a name="database_password"></a> [DATABASE_PASSWORD](#database_password) | no default | Database password |
| <a name="database_ssl_mode"></a> [DATABASE_SSL_MODE](#database_ssl_mode) | no default | For "postgres" only, either "disable", "require" or "verify-full" |
| <a name="database_path"></a> [DATABASE_PATH](#database_path) | no default | For "sqlite3" only, path relative to data_path setting |
| <a name="session_provider"></a> [SESSION_PROVIDER](#session_provider) | file | Either "memory", "file", "redis", "mysql", "postgres", default is "file" |
| <a name="session_provider_config"></a> [SESSION_PROVIDER_CONFIG](#session_provider_config) | no default | Provider config options <br>`memory: not have any config yet`<br>`file: session dir path, is relative to grafana data_path`<br>`redis: addr=127.0.0.1:6379,pool_size=100,db=grafana`<br>`mysql: user:password@tcp(127.0.0.1:3306)/database_name`<br>`postgres: user=a password=b host=localhost port=5432 dbname=c sslmode=disable` |
| <a name="session_cookie_name"></a> [SESSION_COOKIE_NAME](#session_cookie_name) | grafana_sess | Session cookie name |
| <a name="session_life_time"></a> [SESSION_LIFE_TIME](#session_life_time) | 86400 | Session life time, default is 86400 |
| <a name="grafana_reporting"></a> [GRAFANA_REPORTING](#grafana_reporting) | false | Server reporting, sends usage counters to stats.grafana.org every 24 hours. No ip addresses are being tracked, only simple counters to track running instances, dashboard and error counts. It is very helpful to us. Change this option to false to disable reporting. |
| <a name="google_analytics_ua_id"></a> [GOOGLE_ANALYTICS_UA_ID](#google_analytics_ua_id) | no default | Google Analytics universal tracking code, only enabled if you specify an id here |
| <a name="default_user"></a> [DEFAULT_USER](#default_user) | admin | default admin user, created on startup |
| <a name="default_user_password"></a> [DEFAULT_USER_PASSWORD](#default_user_password) | admin | default admin password, can be changed before first start of grafana,  or in profile settings |
| <a name="secret_key"></a> [SECRET_KEY](#secret_key) | SW2YcwTIb9zpOOhoPsMm | used for signing |
| <a name="login_remember_day"></a> [LOGIN_REMEMBER_DAYS](#login_remember_day) | 7 | Auto-login remember days |
| <a name="cookie_username"></a> [COOKIE_USERNAME](#cookie_username) | grafana_user | |
| <a name="cookie_remember_name"></a> [COOKIE_REMEMBER_NAME](#cookie_remember_name) | grafana_remember | |
| <a name="disable_gravatar"></a> [DISABLE_GRAVATAR](#disable_gravatar) | false | disable gravatar profile images |
| <a name="datasource_proxy_whitelist"></a> [DATASOURCE_PROXY_WHITELIST](#datasource_proxy_whitelist) | no default | data source proxy whitelist (ip_or_domain:port seperated by spaces) |
| <a name="allow_sign_up"></a> [ALLOW_SIGN_UP](#allow_sign_up) | true | allow user signup / registration |
| <a name="allow_org_create"></a> [ALLOW_ORG_CREATE](#allow_org_create) | true | Allow non admin users to create organizations |
| <a name="auto_assign_org"></a> [AUTO_ASSIGN_ORG](#auto_assign_org) | true | Set to true to automatically assign new users to the default organization (id 1) |
| <a name="auto_assign_org_role"></a> [AUTO_ASSIGN_ORG_ROLE](#auto_assign_org_role) | Viewer | Default role new users will be automatically assigned (if disabled above is set to true) |
| <a name="login_hint"></a> [LOGIN_HINT](#login_hint) | email or username | Background text for the user field on the login page |
| <a name="anon_access"></a> [ANON_ACCESS](#anon_access) | false | enable anonymous access |
| <a name="org_name"></a> [ORG_NAME](#org_name) | Main Org. | specify organization name that should be used for unauthenticated users |
| <a name="unauthed_user_org_role"></a> [UNAUTHED_USER_ORG_ROLE](#unauthed_user_org_role) | Viewer | specify role for unauthenticated users |
| <a name="github_auth"></a> [GITHUB_AUTH](#github_auth) | no default | Enable Github Auth (true/false) |
| <a name="github_auth_allow_sign_up"></a> [GITHUB_AUTH_ALLOW_SIGN_UP](#github_auth_allow_sign_up) | false | Allow signup with github auth |
| <a name="github_auth_client_id"></a> [GITHUB_AUTH_CLIENT_ID](#github_auth_client_id) | no default | Github Client Auth |
| <a name="github_auth_client_secret"></a> [GITHUB_AUTH_CLIENT_SECRET](#github_auth_client_secret) | no default | Github Auth client secret |
| <a name="github_auth_scopes"></a> [GITHUB_AUTH_SCOPES](#github_auth_scopes) | user:email,read:org | Github Auth Scopes |
| <a name="github_auth_url"></a> [GITHUB_AUTH_URL](#github_auth_url) | https://github.com/login/oauth/authorize | Github authorization URL |
| <a name="github_auth_token_url"></a> [GITHUB_AUTH_TOKEN_URL](#github_auth_token_url) | https://github.com/login/oauth/access_token | Github Auth Token URL |
| <a name="github_auth_api_url"></a> [GITHUB_AUTH_API_URL](#github_auth_api_url) | https://api.github.com/user | Github Auth API URL |
| <a name="github_auth_team_ids"></a> [GITHUB_AUTH_TEAM_IDS](#github_auth_team_ids) | "" | Team IDs to use for Github Auth |
| <a name="github_auth_allowed_orgs"></a> [GITHUB_AUTH_ALLOWED_ORGS](#github_auth_allowed_orgs) | "" | Allowed ORGs for Github Auth |
| <a name="google_auth"></a> [GOOGLE_AUTH](#google_auth) | no default | Enable Google Auth for login (true/false) |
| <a name="google_auth_allow_sign_up"></a> [GOOGLE_AUTH_ALLOW_SIGN_UP](#google_auth_allow_sign_up) | false | Allow people to sign up using Google Auth |
| <a name="google_auth_client_id"></a> [GOOGLE_AUTH_CLIENT_ID](#google_auth_client_id) | no default | Google Auth Client ID |
| <a name="google_auth_client_secret"></a> [GOOGLE_AUTH_CLIENT_SECRET](#google_auth_client_secret) | no default | Google Auth Client Secret |
| <a name="google_auth_scopes"></a> [GOOGLE_AUTH_SCOPES](#google_auth_scopes) | https://www.googleapis.com/auth/userinfo.profile<br> https://www.googleapis.com/auth/userinfo.email | Google Auth Scopes |
| <a name="google_auth_url"></a> [GOOGLE_AUTH_URL](#google_auth_url) | https://accounts.google.com/o/oauth2/auth | Google Auth URL |
| <a name="google_auth_token_url"></a> [GOOGLE_AUTH_TOKEN_URL](#google_auth_token_url) | https://accounts.google.com/o/oauth2/token | Google Auth Token URL |
| <a name="google_auth_api_url"></a> [GOOGLE_AUTH_API_URL](#google_auth_api_url) | https://www.googleapis.com/oauth2/v1/userinfo | Google Auth API URL |
| <a name="google_auth_allowed_domains"></a> [GOOGLE_AUTH_ALLOWED_DOMAINS](#google_auth_allowed_domains) | "" | Google Auth allowed domains |
| <a name="auth_proxy"></a> [AUTH_PROXY](#auth_proxy) | no default | If enabled use an authorization proxy |
| <a name="auth_header_name"></a> [AUTH_HEADER_NAME](#auth_header_name) | X-WEBAUTH-USER | Header to use for authorization |
| <a name="auth_header_property"></a> [AUTH_HEADER_PROPERTY](#auth_header_property) | username | Property to use in Authorization Header |
| <a name="auth_auto_sign_up"></a> [AUTH_AUTO_SIGN_UP](#auth_auto_sign_up) | true | Auto Signup user with data passed from Authorization Header|
| <a name="basic_auth"></a> [BASIC_AUTH](#basic_auth) | true | Enable Basic Auth |
| <a name="ldap_auth"></a> [LDAP_AUTH](#ldap_auth) | no default | Enable LDAP Auth |
| <a name="ldap_auth_config_file"></a> [LDAP_AUTH_CONFIG_FILE](#ldap_auth_config_file) | /etc/grafana/ldap.toml | Config file to use for LDAP Auth |
| <a name="smtp"></a> [SMTP](#smtp) | no default | Enable SMTP/Emailing |
| <a name="smtp_host"></a> [SMTP_HOST](#smtp_host) | no default | SMTP Host |
| <a name="smtp_user"></a> [SMTP_USER](#smtp_user) | no default | User for SMTP |
| <a name="smtp_password"></a> [SMTP_PASSWORD](#smtp_password) | no default | Password for SMTP |
| <a name="smtp_cert_file"></a> [SMTP_CERT_FILE](#smtp_cert_file) | no default | Cert file for SMTP HTTPS |
| <a name="smtp_key_file"></a> [SMTP_KEY_FILE](#smtp_key_file) | no default | Key file for SMTP HTTPS |
| <a name="smtp_skip_verify"></a> [SMTP_SKIP_VERIFY](#smtp_skip_verify) | false | Skip HTTPS verify |
| <a name="smtp_from_address"></a> [SMTP_FROM_ADDRESS](#smtp_from_address) | admin@grafana.localhost | From address to use when sending emails |
| <a name="welcome_email"></a> [WELCOME_EMAIL](#welcome_email) | false | Send welcome email on sign up |
| <a name="log_mode"></a> [LOG_MODE](#log_mode) | console | Either "console", "file", default is "console" Use comma to separate multiple modes, e.g. "console, file" |
| <a name="buffer_length"></a> [BUFFER_LENGTH](#buffer_length) | 10000 | Buffer length of channel, keep it as it is if you don't know what it is. |
| <a name="log_level"></a> [LOG_LEVEL](#log_level) | Info | Either "Trace", "Debug", "Info", "Warn", "Error", "Critical", default is "Trace" |
| <a name="log_level_console"></a> [LOG_LEVEL_CONSOLE](#log_level_console) | Info | For "console" mode only |
| <a name="log_level_file"></a> [LOG_LEVEL_FILE](#log_level_file) | Info | For "file" mode only |
| <a name="log_rotate"></a> [LOG_ROTATE](#log_rotate) | true | This enables automated log rotate(switch of following options), default is true |
| <a name="log_max_lines"></a> [LOG_MAX_LINES](#log_max_lines) | 1000000 | Max line number of single file |
| <a name="log_max_lines_shift"></a> [LOG_MAX_LINES_SHIFT](#log_max_lines_shift) | 28 | Max size shift of single file, default is 28 means 1 << 28, 256MB |
| <a name="log_daily_rotate"></a> [LOG_DAILY_ROTATE](#log_daily_rotate) | true | Segment log daily, default is true |
| <a name="log_max_days"></a> [LOG_MAX_DAYS](#log_max_days) | 7 | Expired days of log file(delete after max days) |
| <a name="amqp_publisher"></a> [AMQP_PUBLISHER](#amqp_publisher) | no default | Publish Events to AMQP |
| <a name="amqp_publisher_host"></a> [AMQP_PUBLISHER_HOST](#amqp_publisher_host) | no default | RabbitMQ URL |
| <a name="amqp_publisher_exchange"></a> [AMQP_PUBLISHER_EXCHANGE](#amqp_publisher_exchange) | no default | AMQP Publisher Exchange |
| <a name="dashboard_json"></a> [DASHBOARD_JSON](#dashboard_json) | true | Poll a location for json files that contain dashboards |
| <a name="dashboard_json_path"></a> [DASHBOARD_JSON_PATH](#dashboard_json_path) | /usr/share/grafana/dashboards | Location to scan for json dashboards |
| <a name="plugins_path"></a> [PLUGINS_PATH](#plugins_path) | /var/lib/grafana/plugins | Path to where grafana can install plugins |
| <a name="gf_install_plugins"></a> [GF_INSTALL_PLUGINS](#gf_install_plugins) | no default | Pass the plugins as a comma seperated list |

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

The typical workflow will look something like this - `DEIS_REGISTRY=quay.io/ IMAGE_PREFIX=foouser make build push upgrade`
