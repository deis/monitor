### v2.0.0-beta4

#### Features

 - [`e9d102b`](https://github.com/deis/monitor/commit/e9d102b06667efadb43c34d9e1b6dd08e5ee6efd) grafana: Use grafana to calc request per second
 - [`5ce1dbf`](https://github.com/deis/monitor/commit/5ce1dbf3484eb3a43b60f6f8c3cdd62b56f06fe3) telegraf: Add the ability to poll kubernetes prometheus endpoints

#### Fixes

 - [`7a156c4`](https://github.com/deis/monitor/commit/7a156c47e50ecdcad1af2068a5bab34720a0bc70) telegraf: Set insecure verify to true
 - [`6b2f8bb`](https://github.com/deis/monitor/commit/6b2f8bbba593412cf0811c46c952cd4465df95df) telegraf: dont remove curl
 - [`2fe7927`](https://github.com/deis/monitor/commit/2fe79274650d141febce12dcf3fbfabdb1b0e600) telegraf: Document agent configuration
 - [`8ea1bd7`](https://github.com/deis/monitor/commit/8ea1bd79c96ee6d7491baa2aecb11e335a454406) influx: Make influx config a go template

#### Documentation


#### Maintenance

 - [`0a474e2`](https://github.com/deis/monitor/commit/0a474e2d99b035ff14805ca8009c834994b36469) grafana: Update to 3.0.0-beta7
 - [`309a589`](https://github.com/deis/monitor/commit/309a589d10ca46e03adebc708bfc8739c8866ea8) grafana: Add node health and kubernetes graphs
 - [`b231c1b`](https://github.com/deis/monitor/commit/b231c1bd834c692176ddbc6e4358c9d1a776fb41) influx: Turn off logging by default
 - [`f63e4b4`](https://github.com/deis/monitor/commit/f63e4b4824deef4b2e2a45af737323345ccc8081) telegraf: Copy paste fail
 - [`eed5d62`](https://github.com/deis/monitor/commit/eed5d6227d214b857a770dae86bb9f67c55eeece) telegraf: Use env var to quiet telegraf instead of cli arg
 - [`9beef58`](https://github.com/deis/monitor/commit/9beef585a96fb3f96eed0bc803e5c3fedb2c03cb) telegraf: Make telegraf run in quiet mode
 - [`c30e88e`](https://github.com/deis/monitor/commit/c30e88ea60780ac6ef238e05e584c4677c5b8aab) telegraf: Update envtpl to 0.1.2
