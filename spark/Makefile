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

SPARK_VERSION=1.5.2
HADOOP_VERSION=2.6

TAG=harisekhon/spark

DIR="spark-$(SPARK_VERSION)-bin-hadoop$(HADOOP_VERSION)"
TAR="$(DIR).tgz"

.PHONY: all
all:
	make build push

.PHONY: build
build:
	[ -d "$(DIR)" ] || wget -c "http://d3kbcqa49mib13.cloudfront.net/$(TAR)" -O "$(TAR)"
	[ -d "$(DIR)" ] || tar zxvf "$(TAR)"
	rm -fv "$(TAR)"
	# multiple tags should arrive in Docker 1.10+
	docker build --build-arg SPARK_VERSION=$(SPARK_VERSION) --build-arg HADOOP_VERSION=$(HADOOP_VERSION) -t $(TAG):$(SPARK_VERSION) . && docker tag -f $(TAG):$(SPARK_VERSION) $(TAG):latest

.PHONY: nocache
nocache:
	make build

.PHONY: push
push:
	docker push $(TAG)

.PHONY: clean
clean:
	rm -rf "$(DIR)" "$(TAR)"

.PHONY: run
run:
	docker run -ti -p 4040:4040 -p 7077:7077 -p 8080:8080 -p 8081:8081 harisekhon/spark
