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

REPO=harisekhon/consul

TAG=$(shell perl -n -e '/^\s*ARG\s+.+_VERSION\s*=\s*(\d+\.\d+)/ && &{ print $$1; exit }' Dockerfile)

ifdef LATEST
	TAG=latest
endif

.PHONY: build
build:
	docker build -t $(REPO):$(TAG) .

.PHONY: build-versions
build-versions:
	for x in $$(git branch -a | grep consul | sed 's,remotes/origin/,,' | sort -u); do \
		git checkout "$$x" && \
		make build || \
		exit 1; \
	done

.PHONY: nocache
nocache:
	docker build -t $(REPO):$(TAG) --no-cache .

.PHONY: push
push:
	docker push $(REPO):$(TAG)
	hooks/post_build

.PHONY: push-versions
push-versions:
	# use 'make push' rather than just 'docker push' to trigger hooks/post_build
	for x in $$(git branch -a | grep consul | sed 's,remotes/origin/,,' | sort -u); do \
		git checkout "$$x" && \
		make push || \
		exit 1; \
	done

.PHONY: build-push-versions
build-push-versions: build-versions push-versions
	:

.PHONY: run
run:
	docker run -ti -p 8500:8500 $(REPO):$(TAG) agent -dev -data-dir /tmp -client 0.0.0.0
