#!/bin/bash
PWD=$(cd "$(dirname "$0")"; pwd)

./cert-gen.sh

make redis

./collectd-shipper.sh
./lumberjack-shipper.sh
./indexer.sh
