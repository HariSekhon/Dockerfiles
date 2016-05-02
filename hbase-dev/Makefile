#
#  Author: Hari Sekhon
#  Date: 2016-04-24 21:32:37 +0100 (Sun, 24 Apr 2016)
#
#  vim:ts=4:sts=4:sw=4:noet
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

HBASE_VERSION=1.2.1

TAG=harisekhon/hbase-dev

.PHONY: all
all:
	make build

.PHONY: build
build:
	docker build --build-arg HBASE_VERSION=$(HBASE_VERSION) -t $(TAG):$(HBASE_VERSION) . && docker tag -f $(TAG):$(HBASE_VERSION) $(TAG):latest

.PHONY: nocache
nocache:
	docker build --no-cache --build-arg HBASE_VERSION=$(HBASE_VERSION) -t $(TAG):$(HBASE_VERSION) . && docker tag -f $(TAG):$(HBASE_VERSION) $(TAG):latest

.PHONY: push
push:
	docker push $(TAG)

.PHONY: clean
clean:
	@echo Nothing to clean

#.PHONY: test
#test:
#	cd .. && make test deps
#	docklint Dockerfile

.PHONY: run
run:
	docker run -ti -p 60000:60000 -p 60010:60010 -p 60020:60020 -p 60030:60030 -p 20550:20550 -p 2181:2181 -p 8080:8080 -p 8085:8085 -p 9090:9090 -p 9095:9095 harisekhon/hbase-dev
