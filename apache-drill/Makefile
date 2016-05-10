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

TAG=harisekhon/apache-drill

.PHONY: all
all:
	make build

.PHONY: build
build:
	docker build -t $(TAG) .

.PHONY: nocache
nocache:
	docker build -t $(TAG) --no-cache .

#.PHONY: push
#push:
#	docker push $(TAG)

#.PHONY: clean
#clean:
#	rm -rf apache-drill-$(DRILL_VERSION)-bin*

#.PHONY: test
#test:
#	cd .. && make test-deps
#	docklint Dockerfile

.PHONY: run
run:
	docker run -t -p 8047:8047 harisekhon/apache-drill
