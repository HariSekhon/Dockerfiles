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

ZOOKEEPER_VERSION=3.4.6

TAG=harisekhon/zookeeper

.PHONY: all
all:
	make build

.PHONY: build
build:
	[ -d zookeeper-$(ZOOKEEPER_VERSION) ] || wget -O zookeeper-$(ZOOKEEPER_VERSION).tar.gz http://www.mirrorservice.org/sites/ftp.apache.org/zookeeper/zookeeper-$(ZOOKEEPER_VERSION)/zookeeper-$(ZOOKEEPER_VERSION).tar.gz
	[ -d zookeeper-$(ZOOKEEPER_VERSION) ] || tar zxvf zookeeper-$(ZOOKEEPER_VERSION).tar.gz
	# makes build slightly quicker but doesn't make image any smaller
	rm -f "zookeeper-$(ZOOKEEPER_VERSION).tar.gz"
	# multiple tags should arrive in Docker 1.10+
	docker build --build-arg ZOOKEEPER_VERSION=$(ZOOKEEPER_VERSION) -t $(TAG):$(ZOOKEEPER_VERSION) . && docker tag -f $(TAG):$(ZOOKEEPER_VERSION) $(TAG):latest

.PHONY: nocache
nocache:
	make build

.PHONY: push
push:
	docker push $(TAG)

.PHONY: clean
clean:
	rm -fr zookeeper-*.tar.gz zookeeper-*

#.PHONY: test
#test:
#	cd .. && make test-deps
#	docklint Dockerfile

.PHONY: run
run:
	docker run -p 2181:2181 harisekhon/zookeeper
