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

REPO := harisekhon/kafka

# override TAG with more specific Scala_Kafka version
TAG = $(shell perl -n -e '/^\s*ARG\s+SCALA_VERSION\s*=\s*(\d+\.\d+)/ && print "$$1"; ' Dockerfile)_$(shell perl -n -e '/^\s*ARG\s+KAFKA_VERSION\s*=\s*(\d+\.\d+)/ && print "$$1"; ' Dockerfile)

MAP_PORTS := 2181 9092

include ../Makefile.in
