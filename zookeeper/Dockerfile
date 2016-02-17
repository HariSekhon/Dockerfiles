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

ARG ZOOKEEPER_VERSION

#ENV PATH $PATH:/zookeeper-$ZOOKEEPER_VERSION

LABEL Description="ZooKeeper" \
      "ZooKeeper Version"="$ZOOKEEPER_VERSION"

COPY zookeeper-$ZOOKEEPER_VERSION /zookeeper
RUN cp -av /zookeeper/conf/zoo_sample.cfg /zookeeper/conf/zoo.cfg

EXPOSE 2181 3181 4181

CMD /zookeeper/bin/zkServer.sh start-foreground
