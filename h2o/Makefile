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

#H2O_VERSION=2.6.1.5
H2O_VERSION=3.8.0.4

TAG=harisekhon/h2o

.PHONY: all
all:
	make build push

.PHONY: build
build:
	# 2.6.1.5
	#[ -d "h2o-$(H2O_VERSION)" ] || wget -c http://h2o-release.s3.amazonaws.com/h2o/rel-lambert/5/h2o-$(H2O_VERSION).zip -O h2o-$(H2O_VERSION).zip
	[ -d "h2o-$(H2O_VERSION)" ] || wget -c http://download.h2o.ai/download/h2o-$(H2O_VERSION) -O h2o-$(H2O_VERSION).zip
	[ -d "h2o-$(H2O_VERSION)" ] || unzip h2o-$(H2O_VERSION).zip
	rm -fv h2o-$(H2O_VERSION).zip
	# multiple tags should arrive in Docker 1.10+
	docker build --build-arg H2O_VERSION=$(H2O_VERSION) -t $(TAG):$(H2O_VERSION) . && docker tag -f $(TAG):$(H2O_VERSION) $(TAG):latest

.PHONY: nocache
nocache:
	make build

.PHONY: push
push:
	docker push $(TAG)

.PHONY: clean
clean:
	rm -rf h2o-$(H2O_VERSION)*

.PHONY: run
run:
	docker run -t -p 54321:54321 harisekhon/h2o
