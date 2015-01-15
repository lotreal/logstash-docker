#!/bin/bash
PWD=$(cd "$(dirname "$0")"; pwd)

export NAME=log-indexer && make indexer
