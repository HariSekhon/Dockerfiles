#
#  Author: Hari Sekhon
#  Date: 2016-04-24 21:32:37 +0100 (Sun, 24 Apr 2016)
#
#  vim:ts=4:sts=4:sw=4:noet
#
#  https://github.com/harisekhon/Dockerfiles/hbase
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

REPO=harisekhon/hbase

TAG=$(shell perl -n -e '/^\s*ARG\s+.+_VERSION\s*=\s*(\d+\.\d+)/ && &{ print $$1; exit }' Dockerfile)

.PHONY: all
all:
	make build

.PHONY: build
build:
	docker build -t $(REPO):$(TAG) .

.PHONY: nocache
nocache:
	docker build -t $(REPO):$(TAG) --no-cache .

.PHONY: run
run:
	docker run -ti -p 2181:2181 -p 8080:8080 -p 8085:8085 -p 9090:9090 -p 9095:9095 -p 16000:16000 -p 16010:16010 -p 16201:16201 -p 16301:16301 $(REPO):$(TAG)
