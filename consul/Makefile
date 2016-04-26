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

CONSUL_VERSION=0.6.3

TAG=harisekhon/consul

.PHONY: all
all:
	make build

.PHONY: build
build:
	#[ -f consul ] || wget -c https://releases.hashicorp.com/consul/$(CONSUL_VERSION)/consul_$(CONSUL_VERSION)_linux_amd64.zip
	#[ -f consul ] || unzip -o consul_$(CONSUL_VERSION)_linux_amd64.zip
	# makes build slightly quicker but doesn't make image any smaller
	#rm -f consul_$(CONSUL_VERSION)_linux_amd64.zip
	# multiple tags should arrive in Docker 1.10+
	docker build --build-arg CONSUL_VERSION=$(CONSUL_VERSION) -t $(TAG):$(CONSUL_VERSION) . && docker tag -f $(TAG):$(CONSUL_VERSION) $(TAG):latest

.PHONY: nocache
nocache:
	make build

.PHONY: push
push:
	docker push $(TAG)

.PHONY: clean
clean:
	rm consul_*_linux_amd64.zip consul

#.PHONY: test
#test:
#	cd .. && make test-deps
#	docklint Dockerfile

.PHONY: run
run:
	docker run -p 8500:8500 harisekhon/consul agent -dev -data-dir /tmp -client 0.0.0.0
