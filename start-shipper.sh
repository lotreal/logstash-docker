#!/bin/bash
PWD=$(cd "$(dirname "$0")"; pwd)

export NAME=log-shipper1 && make shipper
export NAME=log-shipper2 && make shipper
