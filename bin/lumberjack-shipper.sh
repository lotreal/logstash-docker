#!/bin/bash
cd "$(dirname "$0")/.."
make shipper NAME=log-lumberjack CONFIG=etc/shipper/lumberjack.conf DFLAGS="--publish 5043:5043/tcp --volume $(pwd)/cert:/opt/ssl"
