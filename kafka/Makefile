#
#  Author: Hari Sekhon
#  Date: 2016-01-16 12:21:15 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:noet
#
#  https://github.com/harisekhon/Dockerfiles/kafka
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

REPO=harisekhon/kafka

TAG=$(shell perl -n -e '/^\s*ARG\s+SCALA_VERSION\s*=\s*(\d+\.\d+)/ && print "$$1"; ' Dockerfile)_$(shell perl -n -e '/^\s*ARG\s+KAFKA_VERSION\s*=\s*(\d+\.\d+)/ && print "$$1"; ' Dockerfile)

.PHONY: all
all:
	make build

.PHONY: build
build:
	docker build -t $(REPO):$(TAG) .

.PHONY: nocache
nocache:
	docker build -t $(REPO):$(TAG) --no-cache .

.PHONY: push
push:
	docker push $(REPO):$(TAG)

.PHONY: run
run:
	docker run -ti -p 2181:2181 -p 9092:9092 $(REPO):$(TAG)
