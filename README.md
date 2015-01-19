# Logstash-Docker

Run logstash with docker.

## Requirements

- redis

```
docker run --detach --name redis --restart=on-failure:10 redis
```

## Quick Start

```
git clone https://github.com/lotreal/logstash-docker.git
cd logstash-docker
```

### log-indexer

```
./bin/indexer.sh
```

### log-forwarder-shipper

log-forwarder-shipper is a shipper, use port 5043/tcp, recive data sended with [lumberjack protocol](https://github.com/elasticsearch/logstash-forwarder).

*Note:* If you meet ssl certificate problem, try generate ssl certificate use `./bin/cert-gen.sh`

```
./bin/lumberjack-shipper.sh
```

### log-collectd-shipper

log-collectd-shipper is a shipper, use port 25826/udp, recive data sended by [collectd](https://collectd.org).

```
./bin/collectd-shipper.sh
```


## Settings

### ssl certificate

put ssl certificate for log-forwarder at:

- cert/logstash-forwarder.key
- cert/logstash-forwarder.crt

### logstash config

```
ls etc
```
