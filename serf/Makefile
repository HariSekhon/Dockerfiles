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
#  http://www.linkedin.com/in/harisekhon
#

SERF_VERSION=0.7.0

make:
	wget -c https://releases.hashicorp.com/serf/$(SERF_VERSION)/serf_$(SERF_VERSION)_linux_amd64.zip
	unzip -o serf_$(SERF_VERSION)_linux_amd64.zip
	# makes build slightly quicker but doesn't make image any smaller
	#rm -f serf_$(SERF_VERSION)_linux_amd64.zip
	# multiple tags should arrive in Docker 1.10+
	docker build --build-arg SERF_VERSION=$(SERF_VERSION) -t harisekhon/serf:$(SERF_VERSION) . && docker tag -f harisekhon/serf:$(SERF_VERSION) harisekhon/serf:latest

clean:
	rm serf_*_linux_amd64.zip serf
