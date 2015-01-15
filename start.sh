#!/bin/bash
PWD=$(cd "$(dirname "$0")"; pwd)

./cert-gen.sh

make redis

export NAME=log-shipper1 && make shipper
export NAME=log-shipper2 && make shipper

export NAME=log-indexer && make indexer
