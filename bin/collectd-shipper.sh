#!/bin/bash
cd "$(dirname "$0")/.."
make shipper NAME=log-collectd CONFIG=etc/shipper/collectd.conf DFLAGS="--publish 25826:25826/udp"
