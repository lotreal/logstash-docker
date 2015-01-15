BSDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# Sample: NAME=ls-shipper make run
NAME ?= logstash
IMAGE = lotreal/logstash:1.42


define log_indexer_flags
--link redis:redis \
--link es:es \
--volume $(BSDIR)/etc/indexer.conf:/etc/logstash.conf
endef

define log_shipper_flags
--link redis:redis \
--expose 5043/tcp \
--volume $(BSDIR)/cert:/opt/ssl \
--volume $(BSDIR)/etc/shipper.conf:/etc/logstash.conf
endef


.PHONY: test
test:
	docker run --rm -it $(log_indexer_flags) $(IMAGE) bash

.PHONY: build
build:
	docker build --tag $(IMAGE) .

.PHONY: indexer
indexer:
	echo docker run --detach --name $(NAME) $(log_indexer_flags) $(IMAGE)

.PHONY: shipper
shipper:
	echo docker run --detach --name $(NAME) $(log_shipper_flags) $(IMAGE)

.PHONY: shell
shell:
	docker exec -it $(NAME) bash
