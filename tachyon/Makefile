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

TACHYON_VERSION=0.8.2

TAG=harisekhon/tachyon

.PHONY: all
all:
	make build

.PHONY: build
build:
	# done in Docker now
	#[ -d "tachyon-$(TACHYON_VERSION)" ] || wget -c http://tachyon-project.org/downloads/files/$(TACHYON_VERSION)/tachyon-$(TACHYON_VERSION)-bin.tar.gz
	#[ -d "tachyon-$(TACHYON_VERSION)" ] || tar zxvf tachyon-$(TACHYON_VERSION)-bin.tar.gz
	#rm -fv tachyon-$(TACHYON_VERSION)-bin.tar.gz
	# multiple tags should arrive in Docker 1.10+
	docker build --build-arg TACHYON_VERSION=$(TACHYON_VERSION) -t $(TAG):$(TACHYON_VERSION) . && docker tag -f $(TAG):$(TACHYON_VERSION) $(TAG):latest

.PHONY: nocache
nocache:
	make build

.PHONY: push
push:
	docker push $(TAG)

.PHONY: clean
clean:
	rm -rf tachyon-$(TACHYON_VERSION)-bin*

#.PHONY: test
#test:
#	cd .. && make test-deps
#	docklint Dockerfile

.PHONY: run
run:
	docker run -t -p 19999:19999 -p 30000:30000 harisekhon/tachyon
