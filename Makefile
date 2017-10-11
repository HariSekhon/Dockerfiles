#
#  Author: Hari Sekhon
#  Date: 2016-01-19 23:14:35 +0000 (Tue, 19 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:noet
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback
#
#  https://www.linkedin.com/in/harisekhon
#

# On Ubuntu this fails to pushd otherwise
SHELL=/usr/bin/env bash

# EUID /  UID not exported in Make
# USER not populated in Docker
#ifeq '$(shell id -u)' '0'
#	SUDO =
#	SUDO2 =
#else
#	SUDO = sudo
#endif

.PHONY: all
all: build
	:

.PHONY: build
build:
	# do not just break as it will fail and move to next push target in build-push
	for x in *; do [ -d $$x ] || continue; pushd $$x && make build && popd || exit 1; done

.PHONY: build-push
build-push: build dockerpush
	:

tags:
	./build_tags.sh

.PHONY: nocache
nocache:
	for x in *; do [ -d $$x ] || continue; pushd $$x && make nocache && popd || exit 1; done

#.PHONY: apt-packages
#apt-packages:
#	$(SUDO) apt-get update
#	$(SUDO) apt-get install -y npm
#	$(SUDO) apt-get install -y which
#
#.PHONY: yum-packages
#yum-packages:
#	rpm -q rpm || $(SUDO) yum install -y npm
#	rpm -q rpm || $(SUDO) yum install -y which
#
#.PHONY: test-deps
#test-deps:
#	if [ -x /usr/bin/apt-get ]; then make apt-packages; fi
#	if [ -x /usr/bin/yum ];     then make yum-packages; fi
#	# this is clearly too basic - it doesn't even recognize LABEL instruction, nor line continuations
#	which docklint &>/dev/null || npm install -g validate-dockerfile

.PHONY: test
test:
	@# this would test everything but would call test-deps over and over inefficiently
	@#for x in *; do [ -d $$x ] || continue; pushd $$x; make test; popd; done
	@#make test-deps
	@#find . -name Dockerfile | xargs -n1 docklint
	tests/all.sh

.PHONY: push
push:
	git push --all

.PHONY: pull
pull:
	for branch in $$(git branch -a); do \
		echo "git checkout $$branch" && \
		git checkout $$branch && \
		echo "git pull" && \
		git pull || \
		exit 1; \
	done

.PHONY: dockerpull
dockerpull:
	for x in *; do [ -d $$x ] || continue; docker pull harisekhon/$$x || exit 1; done

.PHONY: dockerpush
dockerpush:
	# use make push which will also call hooks/post_build
	for x in *; do \
		[ -d "$$x" ] || continue; \
		pushd "$$x" && \
		make push && \
		popd || \
		exit 1; \
	done

.PHONY: update
update: update2 build
	:

.PHONY: update2
update2: update-no-recompile
	:

.PHONY: update-no-recompile
update-no-recompile:
	git pull
	git submodule update --init --recursive

.PHONY: update-submodules
update-submodules:
	git submodule update --init --remote
.PHONY: updatem
updatem: update-submodules
	:

# this would apply to all recipes
#.ONESHELL:
.PHONY: nagios-plugins
nagios-plugins:
	for x in \
		nagios-plugins-centos \
		nagios-plugins-ubuntu \
		nagios-plugins-debian \
		nagios-plugins-alpine \
		; do \
		pushd $$x && \
		make nocache test && \
		{ make push & popd; } || \
		break; \
	done

.PHONY: github
github:
	# has no test target, consider adding one
	for x in \
		centos-github \
		ubuntu-github \
		debian-github \
		alpine-github \
		; do \
		pushd $$x && \
		make nocache push && \
		{ make push & popd; } || \
		break; \
	done
