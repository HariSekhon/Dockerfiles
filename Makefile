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

ifneq ("$(wildcard bash-tools/Makefile.in)", "")
	include bash-tools/Makefile.in
endif

# On Ubuntu this fails to pushd otherwise
# fails to bootstrap on Alpine
#SHELL := /usr/bin/env bash

REPO := HariSekhon/Dockerfiles

CODE_FILES := $(shell find . -type f -name '*.py' -o -type f -name '*.sh' | grep -v -e bash-tools)

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
	for x in *; do \
		[ -d $$x ] || continue; \
		tests/exclude.sh "$$x" && continue; \
		pushd $$x && \
		$(MAKE) build && \
		popd || \
		exit 1; \
	done

.PHONY: build-push
build-push: build dockerpush
	:

tags:
	./build_tags.sh

.PHONY: nocache
nocache:
	for x in *; do \
		[ -d $$x ] || continue; \
		tests/exclude.sh "$$x" && continue; \
		pushd $$x && \
		$(MAKE) nocache && \
		popd || \
		exit 1; \
	done

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
#	if [ -x /usr/bin/apt-get ]; then $(MAKE) apt-packages; fi
#	if [ -x /usr/bin/yum ];     then $(MAKE) yum-packages; fi
#	# this is clearly too basic - it doesn't even recognize LABEL instruction, nor line continuations
#	which docklint &>/dev/null || npm install -g validate-dockerfile

.PHONY: test
test:
	@# this would test everything but would call test-deps over and over inefficiently
	@#for x in *; do [ -d $$x ] || continue; pushd $$x; $(MAKE) test; popd; done
	@#$(MAKE) test-deps
	@#find . -name Dockerfile | xargs -n1 docklint
	tests/all.sh

.PHONY: push
push:
	git push --all

.PHONY: pull
pull:
	git checkout master && \
	git pull && \
	for branch in $$(git branch -a | grep -v -e remotes/ | sed 's/\*//'); do \
		echo "git checkout $$branch" && \
		git checkout "$$branch" && \
		echo "git pull" && \
		git pull || \
		exit 1; \
	done; \
	git checkout master

.PHONY: dockerpull
dockerpull:
	for x in *; do [ -d $$x ] || continue; docker pull harisekhon/$$x || exit 1; done

.PHONY: dockerpush
dockerpush:
	# use make push which will also call hooks/post_build
	for x in *; do \
		[ -d "$$x" ] || continue; \
		tests/exclude.sh "$$x" && continue; \
		pushd "$$x" && \
		$(MAKE) push && \
		popd || \
		exit 1; \
	done

.PHONY: sync-hooks
sync-hooks:
	# some hooks are different to the rest so excluded, not git checkout overwritten in case they have pending changes
	latest_hook=`ls -t */hooks/post_build | egrep -v "nagios-plugins-centos" | head -n1`; \
	for x in */hooks/post_build; do \
		if [[ "$$x" =~ nagios-plugins-centos ]] || \
		   [[ "$$x" =~ devops-.*-tools ]]; then \
			continue; \
		fi; \
		if git status --porcelain "$$x/hooks/post_build" | grep -q '^.M'; then \
			echo "$$x/hooks/post_build has pending modifications, skipping..."; \
			continue; \
		fi; \
		if [ "$$latest_hook" != "$$x" ]; then \
			cp -v "$$latest_hook" "$$x"; \
		fi; \
	done; \

.PHONY: commit-hooks
commit-hooks:
	git commit -m "updated post build hooks" `git status -s */hooks | grep ^.M | awk '{print $$2}'`

# TODO: finish and remove ranger
.PHONY: post-build
post-build:
	@for x in *; do \
		[ -d "$$x" ] || continue; \
		[ "$$x" = h2o ] && continue; \
		[ "$$x" = presto-dev ] && continue; \
		[ "$$x" = ranger ] && continue; \
		[ "$$x" = riak ] && continue; \
		[ "$$x" = teamcity ] && continue; \
		if [ -f "$$x/hooks/post_build" ]; then \
			echo "$$x/hooks/post_build"; \
			"$$x/hooks/post_build" || exit 1; \
			echo; \
		fi; \
	done
.PHONY: postbuild
postbuild: post-build
	:

.PHONY: mergemaster
mergemaster:
	bash-tools/git_merge_master.sh

.PHONY: mergemasterpull
mergemasterpull:
	bash-tools/git_merge_master_pull.sh

.PHONY: mergeall
mergeall:
	bash-tools/git_merge_all.sh

# this would apply to all recipes
#.ONESHELL:
.PHONY: nagios-plugins
nagios-plugins:
	for x in nagios-plugins*; do \
		pushd $$x && \
		$(MAKE) nocache push; \
		popd; \
	done
	docker images | grep nagios-plugins

.PHONY: nagios
nagios: nagios-plugins
	:

.PHONY: build-github
build-github:
	# has no test target, consider adding one
	for x in *-github; do \
		pushd $$x && \
		$(MAKE) nocache push; \
		popd
	done
	docker images | grep github

.PHONY: status
status:
	@tests/check_dockerhub_statuses.sh
