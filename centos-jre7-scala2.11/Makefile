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

TAG=harisekhon/centos-jre7-scala2.11
SCALA_VERSION=2.11.7

.PHONY: all
all:
	make build push

.PHONY: build
build:
	docker build --build-arg SCALA_VERSION=$(SCALA_VERSION) -t $(TAG):$(SCALA_VERSION) . && docker tag -f $(TAG):$(SCALA_VERSION) $(TAG):latest

.PHONY: nocache
nocache:
	make build

.PHONY: push
push:
	docker push $(TAG)

.PHONY: clean
clean:
	@echo Nothing to clean
