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

#FROM harisekhon/centos-jre7
# > 100MB smaller than centos
FROM harisekhon/debian-jre7
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG ZOOKEEPER_VERSION=3.4.6
ARG TAR=zookeeper-${ZOOKEEPER_VERSION}.tar.gz

ENV PATH $PATH:/zookeeper/bin

LABEL Description="ZooKeeper" \
      "ZooKeeper Version"="$ZOOKEEPER_VERSION"

#COPY zookeeper-$ZOOKEEPER_VERSION /zookeeper

RUN \
    apt-get update && \
    apt-get install -y curl tar && \
    curl "http://www.mirrorservice.org/sites/ftp.apache.org/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/${TAR}" > "${TAR}" && \
    tar zxvf "${TAR}" && \
    rm -fv "${TAR}" && \
    ln -s zookeeper-${ZOOKEEPER_VERSION} zookeeper && \
    cp -av /zookeeper/conf/zoo_sample.cfg /zookeeper/conf/zoo.cfg && \
    apt-get purge -y curl tar && \
    apt-get autoremove -y && \
    apt-get clean

EXPOSE 2181 3181 4181

CMD /zookeeper/bin/zkServer.sh start-foreground
