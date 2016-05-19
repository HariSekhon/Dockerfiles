#
#  Author: Hari Sekhon
#  Date: 2016-04-24 21:32:37 +0100 (Sun, 24 Apr 2016)
#
#  vim:ts=4:sts=4:sw=4:noet
#
#  https://github.com/harisekhon/Dockerfiles/solrcloud-dev
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

TAG=harisekhon/solrcloud-dev

.PHONY: all
all:
	make build

.PHONY: build
build:
	docker build -t $(TAG) .

.PHONY: nocache
nocache:
	docker build -t $(TAG) --no-cache .

.PHONY: run
run:
	docker run -ti -p 8983:8983 -p 8984:8984 -p 9983 harisekhon/solrcloud-dev
