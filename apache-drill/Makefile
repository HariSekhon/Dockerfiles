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

DRILL_VERSION=1.4.0
DRILL_HEAP=900M
# use this name in container linking
ZOOKEEPER_HOST=zookeeper

TAG=harisekhon/apache-drill

.PHONY: all
all:
	make build push

.PHONY: build
build:
	[ -d "apache-drill-$(DRILL_VERSION)" ] || wget -c 'http://www.apache.org/dyn/closer.lua?filename=drill/drill-$(DRILL_VERSION)/apache-drill-$(DRILL_VERSION).tar.gz&action=download' -O apache-drill-$(DRILL_VERSION).tar.gz
	[ -d "apache-drill-$(DRILL_VERSION)" ] || tar zxvf apache-drill-$(DRILL_VERSION).tar.gz
	perl -pi -e "s/^DRILL_HEAP=\".+\"/DRILL_HEAP=\"$(DRILL_HEAP)\"/" "apache-drill-$(DRILL_VERSION)/conf/drill-env.sh"
	perl -pi -e "s/^(\s*)zk.connect:.*/\\1zk.connect: \"$(ZOOKEEPER_HOST)\"/" "apache-drill-$(DRILL_VERSION)/conf/drill-override.conf"
	rm -fv apache-drill-$(DRILL_VERSION).tar.gz
	# multiple tags should arrive in Docker 1.10+
	docker build --build-arg DRILL_VERSION=$(DRILL_VERSION) -t $(TAG):$(DRILL_VERSION) . && docker tag -f $(TAG):$(DRILL_VERSION) $(TAG):latest

.PHONY: nocache
nocache:
	make build

.PHONY: push
push:
	docker push $(TAG)

.PHONY: clean
clean:
	rm -rf apache-drill-$(DRILL_VERSION)-bin*

#.PHONY: test
#test:
#	cd .. && make test-deps
#	docklint Dockerfile

.PHONY: run
run:
	docker run -t -p 8047:8047 harisekhon/apache-drill
