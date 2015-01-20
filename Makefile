BSDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# Sample: NAME=ls-shipper make run
NAME ?= logstash
IMAGE = lotreal/logstash:1.42
CONFIG ?= etc/indexer.conf
TYPE ?= indexer


define lflags
--name $(NAME) \
--link redis:redis \
--volume $(BSDIR)/$(CONFIG):/etc/logstash.conf
endef


ifeq ($(TYPE), indexer)
CONFIG = etc/indexer.conf
DFLAGS = $(lflags) --link es:es
endif

ifeq ($(TYPE), collectd)
CONFIG = etc/shipper/collectd.conf
DFLAGS = $(lflags) --publish 25826:25826/udp
endif

ifeq ($(TYPE), forwarder)
CONFIG = etc/shipper/lumberjack.conf
DFLAGS = $(lflags) --publish 5043:5043/tcp --volume $(pwd)/cert:/opt/ssl
endif


.PHONY: build
build:
	docker build --tag $(IMAGE) .

.PHONY: pull
pull:
	docker pull $(IMAGE)

.PHONY: push
push:
	docker push $(IMAGE)

.PHONY: test
test:
	echo $(TYPE)
	echo docker run --rm -it $(DFLAGS) $(IMAGE) bash

.PHONY: clean
clean:
	docker rm -f $(NAME)

.PHONY: redis
redis:
	docker run --detach --name redis --restart=on-failure:10 redis

.PHONY: run
run:
	docker run --detach $(DFLAGS) $(IMAGE)

.PHONY: shell
shell:
	docker exec -it $(NAME) bash
