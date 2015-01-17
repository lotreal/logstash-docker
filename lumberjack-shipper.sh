#!/bin/bash
PWD=$(cd "$(dirname "$0")"; pwd)
make shipper NAME=log-lumberjack CONFIG=etc/shipper/lumberjack.conf DFLAGS="--publish 5043:5043/tcp --volume $PWD/cert:/opt/ssl"
