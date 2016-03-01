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

SCALA_VERSION=2.10
KAFKA_VERSION=0.8.2.2

ADVERTISED_HOSTNAME=192.168.99.100

TAG=harisekhon/kafka_scala-$(SCALA_VERSION)

.PHONY: all
all:
	make build

.PHONY: build
build:
	[ -d "kafka_$(SCALA_VERSION)-$(KAFKA_VERSION)" ] || wget -c 'https://www.apache.org/dyn/closer.cgi?filename=/kafka/$(KAFKA_VERSION)/kafka_$(SCALA_VERSION)-$(KAFKA_VERSION).tgz&action=download' -O 'kafka_$(SCALA_VERSION)-$(KAFKA_VERSION).tgz'
	[ -d "kafka_$(SCALA_VERSION)-$(KAFKA_VERSION)" ] || tar zxvf kafka_$(SCALA_VERSION)-$(KAFKA_VERSION).tgz
	rm -fv kafka_$(SCALA_VERSION)-$(KAFKA_VERSION).tgz
	perl -pi.orig -e 's/\s*#?\s*advertised.host.name.*/advertised.host.name=$(ADVERTISED_HOSTNAME)/' 'kafka_$(SCALA_VERSION)-$(KAFKA_VERSION)/config/server.properties'
	# multiple tags should arrive in Docker 1.10+
	docker build --build-arg SCALA_VERSION=$(SCALA_VERSION) --build-arg KAFKA_VERSION=$(KAFKA_VERSION) -t $(TAG):$(KAFKA_VERSION) . && docker tag -f $(TAG):$(KAFKA_VERSION) $(TAG):latest

.PHONY: nocache
nocache:
	make build

.PHONY: push
push:
	docker push $(TAG)

.PHONY: clean
clean:
	rm -rf kafka_$(SCALA_VERSION)-$(KAFKA_VERSION)*

#.PHONY: test
#test:
#	cd .. && make test-deps
#	docklint Dockerfile

.PHONY: run
run:
	docker run -t -p 2181:2181 -p 9092:9092 $(TAG)
