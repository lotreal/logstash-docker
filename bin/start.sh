#!/bin/bash
PWD=$(cd "$(dirname "$0")"; pwd)

./cert-gen.sh

make redis

NAME=log-collectd TYPE=collectd make pull run
NAME=log-forwarder TYPE=forwarder make pull run

NAME=log-indexer TYPE=indexer make pull run
