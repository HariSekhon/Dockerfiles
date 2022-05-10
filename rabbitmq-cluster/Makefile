#
#  Author: Hari Sekhon
#  Date: 2016-01-16 12:21:15 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:noet
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

REPO := harisekhon/rabbitmq-cluster

include ../Makefile.in

run:
	#docker run -ti $$(for x in 5672 15672; do echo -p $$x:$$x; done) $(REPO):$(TAG)
	docker-compose up
