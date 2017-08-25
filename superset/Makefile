#
#  Author: Hari Sekhon
#  Date: 2017-08-22 14:16:43 +0200 (Tue, 22 Aug 2017)
#
#  vim:ts=4:sts=4:sw=4:noet
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

REPO=harisekhon/superset

.PHONY: all
all:
	make build

.PHONY: build
build:
	docker build -t $(REPO) .

.PHONY: nocache
nocache:
	docker build -t $(REPO) --no-cache .

.PHONY: push
push:
	docker push $(REPO)

.PHONY: run
run:
	docker run -ti -p 8088:8088 $(REPO)
