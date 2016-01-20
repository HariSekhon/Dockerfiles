#
#  Author: Hari Sekhon
#  Date: 2016-01-19 23:14:35 +0000 (Tue, 19 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:noet
#
#  https://github.com/harisekhon
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback
#
#  http://www.linkedin.com/in/harisekhon
#

all:
	make build

build:
	for x in *; do [ -d $$x ] || continue; pushd $$x; make; popd; done

nocache:
	for x in *; do [ -d $$x ] || continue; pushd $$x; make nocache; popd; done
