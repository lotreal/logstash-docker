#!/bin/bash
PWD=$(cd "$(dirname "$0")"; pwd)
make indexer NAME=log-indexer
