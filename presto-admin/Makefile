#
#  Author: Hari Sekhon
#  Date: 2017-09-13 14:47:23 +0200 (Wed, 13 Sep 2017)
#
#  vim:ts=4:sts=4:sw=4:noet
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

REPO := harisekhon/presto-admin

include ../Makefile.in

MAP_PORTS := 8080

.PHONY: history
history:
	./build_historic_versions.sh

.PHONY: history
history-push:
	PUSH=1 ./build_historic_versions.sh

.PHONY: build-versions
build-versions: build history
	:

.PHONY: build-push-versions
build-push-versions: history-push
	:
