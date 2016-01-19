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
#  http://www.linkedin.com/in/harisekhon
#

CONSUL_VERSION=0.6.3

TAG=harisekhon/consul

all:
	make build push

build:
	wget -c https://releases.hashicorp.com/consul/$(CONSUL_VERSION)/consul_$(CONSUL_VERSION)_linux_amd64.zip
	unzip -o consul_$(CONSUL_VERSION)_linux_amd64.zip
	# makes build slightly quicker but doesn't make image any smaller
	#rm -f consul_$(CONSUL_VERSION)_linux_amd64.zip
	# multiple tags should arrive in Docker 1.10+
	docker build --build-arg CONSUL_VERSION=$(CONSUL_VERSION) -t $(TAG):$(CONSUL_VERSION) . && docker tag -f $(TAG):$(CONSUL_VERSION) $(TAG):latest

push:
	docker push $(TAG)

clean:
	rm consul_*_linux_amd64.zip consul
