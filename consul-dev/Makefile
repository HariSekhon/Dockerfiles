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

REPO := harisekhon/consul-dev

include ../Makefile.in

run:
	# -dev flag >= 0.6 only, use -server -bootstrap instead
	docker run -ti -p 8500:8500 $(REPO):$(TAG) consul agent -server -bootstrap -data-dir /tmp -client 0.0.0.0
