#
#  Author: Hari Sekhon
#  Date: 2016-04-24 21:18:57 +0100 (Sun, 24 Apr 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback
#
#  https://www.linkedin.com/in/harisekhon
#

FROM harisekhon/centos-dev
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG HADOOP_VERSION=2.7.2
ARG TAR=hadoop-$HADOOP_VERSION.tar.gz

ENV PATH $PATH:/hadoop/bin
ENV JAVA_HOME /usr

LABEL Description="Hadoop Dev", \
      "Hadoop Version"="$HADOOP_VERSION"

WORKDIR /

RUN \
    yum install -y openssh-server && \
    wget -O "$TAR" "http://www.apache.org/dyn/closer.lua?filename=hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-$HADOOP_VERSION.tar.gz&action=download" && \
    tar zxvf "$TAR" && \
    ln -sv hadoop-$HADOOP_VERSION hadoop && \
    rm -fv "$TAR" && \
    /hadoop/bin/hdfs namenode -format

COPY entrypoint.sh /
COPY core-site.xml /hadoop/etc/hadoop/
COPY hdfs-site.xml /hadoop/etc/hadoop/
COPY yarn-site.xml /hadoop/etc/hadoop/
COPY mapred-site.xml /hadoop/etc/hadoop/

EXPOSE 8020 8032 8088 9000 10020 19888 50010 50020 50070 50075 50090

CMD "/entrypoint.sh"
