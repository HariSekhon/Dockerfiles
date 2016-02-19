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

MESOS_VERSION=0.23.0

TAG=harisekhon/mesos

.PHONY: all
all:
	make build push

.PHONY: build
build:
	#[ -d "mesos-$(MESOS_VERSION)" ] || wget -c http://archive.apache.org/dist/mesos/$(MESOS_VERSION)/mesos-$(MESOS_VERSION).tar.gz
	#[ -d "mesos-$(MESOS_VERSION)" ] || tar zxvf mesos-$(MESOS_VERSION).tar.gz
	#rm -fv mesos-$(MESOS_VERSION).tar.gz
	#wget -c http://downloads.mesosphere.io/master/debian/8/mesos_$(MESOS_VERSION)-0.2.190.debian81_amd64.deb
	# multiple tags should arrive in Docker 1.10+
	docker build --build-arg MESOS_VERSION=$(MESOS_VERSION) -t $(TAG):$(MESOS_VERSION) . && docker tag -f $(TAG):$(MESOS_VERSION) $(TAG):latest

.PHONY: nocache
nocache:
	make build

.PHONY: push
push:
	docker push $(TAG)

.PHONY: clean
clean:
	rm -rf mesos-$(MESOS_VERSION)*

#.PHONY: test
#test:
#	cd .. && make test-deps
#	docklint Dockerfile

.PHONY: run
run:
	docker run -t -p 5050-5051:5050-5051 harisekhon/mesos
