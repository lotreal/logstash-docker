BSDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# Sample: NAME=ls-shipper make run
NAME ?= logstash
IMAGE = lotreal/logstash:1.42
CONFIG ?= etc/indexer.conf

define common_logstash_flags
--name $(NAME) \
--link redis:redis \
--volume $(BSDIR)/$(CONFIG):/etc/logstash.conf
endef

define log_shipper_flags
$(common_logstash_flags) \
$(DFLAGS)
endef

define log_indexer_flags
--name $(NAME) \
--link redis:redis \
--link es:es \
--volume $(BSDIR)/$(CONFIG):/etc/logstash.conf \
$(DFLAGS)
endef


.PHONY: test
test:
	echo docker run --rm -it $(logstash_flags) $(IMAGE) bash

.PHONY: build
build:
	docker build --tag $(IMAGE) .

.PHONY: redis
redis:
	docker run --detach --name redis --restart=on-failure:10 redis

.PHONY: indexer
indexer:
	docker run --detach --name log-indexer $(log_indexer_flags) $(IMAGE)

.PHONY: shipper
shipper:
	docker run --detach $(log_shipper_flags) $(IMAGE)

.PHONY: shell
shell:
	docker exec -it $(NAME) bash
