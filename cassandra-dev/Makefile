#
#  Author: Hari Sekhon
#  Date: 2016-01-16 12:21:15 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:noet
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

CASSANDRA_VERSION=22

TAG=harisekhon/cassandra

.PHONY: all
all:
	make build push

.PHONY: build
build:
	docker build --build-arg CASSANDRA_VERSION=$(CASSANDRA_VERSION) -t $(TAG):$(CASSANDRA_VERSION) . && docker tag -f $(TAG):$(CASSANDRA_VERSION) $(TAG):latest

.PHONY: nocache
nocache:
	docker build --no-cache --build-arg CASSANDRA_VERSION=$(CASSANDRA_VERSION) -t $(TAG):$(CASSANDRA_VERSION) . && docker tag -f $(TAG):$(CASSANDRA_VERSION) $(TAG):latest

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
	docker run -ti -p 7199:7199 -p 9042:9042 -p 9160:9160 harisekhon/cassandra
