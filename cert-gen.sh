#!/bin/bash
cd "$(dirname "$0")"

PKI_DIR=cert


if [ ! -d "${PKI_DIR}" ]; then
  mkdir ${PKI_DIR} && cd ${PKI_DIR}
  wget https://github.com/driskell/log-courier/raw/develop/src/lc-tlscert/lc-tlscert.go
  cd ..
fi

cd ${PKI_DIR}

docker run --rm -v "$(pwd)":/usr/src/myapp -w /usr/src/myapp golang go build -v lc-tlscert.go

echo -e "\n$1\n\n3650\n" | ./lc-tlscert

mv selfsigned.key logstash-forwarder.key
mv selfsigned.crt logstash-forwarder.crt

chmod 644 logstash-forwarder.*

cd ..
