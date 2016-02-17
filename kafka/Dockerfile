#
#  Author: Hari Sekhon
#  Date: 2016-01-16 09:58:07 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM harisekhon/centos-jre7
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG SCALA_VERSION
ARG KAFKA_VERSION

ENV PATH $PATH:/kafka/bin

LABEL Description="Apache Kafka by LinkedIn" \
      "Scala Version"="$SCALA_VERSION" \
      "Kafka Version"="$KAFKA_VERSION"

# use dev build it's quicker and cached
#RUN yum install -y java-1.7.0-openjdk && yum clean all

COPY kafka_$SCALA_VERSION-$KAFKA_VERSION /kafka

EXPOSE 2181 9092

CMD zookeeper-server-start.sh /kafka/config/zookeeper.properties & \
    echo "*** waiting for 10 secs to give ZooKeeper time to start up"; \
    sleep 10; \
    echo "# ============================================================================ #"; \
    echo " S t a r t i n g   K a f k a"; \
    echo "# ============================================================================ #"; \
    kafka-server-start.sh /kafka/config/server.properties
