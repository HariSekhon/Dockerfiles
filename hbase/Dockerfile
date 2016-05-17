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

FROM harisekhon/centos-java:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

#ARG HBASE_VERSION=0.94.27
#ARG HBASE_VERSION=0.96.2
ARG HBASE_VERSION=0.98.19
#ARG HBASE_VERSION=1.0.3
#ARG HBASE_VERSION=1.1.4
#ARG HBASE_VERSION=1.2.1

ENV PATH $PATH:/hbase/bin

LABEL Description="HBase Dev", \
      "HBase Version"="$HBASE_VERSION"

WORKDIR /

RUN \
    yum install -y wget tar && \
    # HBase 0.94
    #wget -O "hbase-$HBASE_VERSION-bin.tar.gz" "http://www.apache.org/dyn/closer.lua?filename=hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION.tar.gz&action=download" && \
    # HBase 0.96
    # usually missing from mirrors, have to use apache archive
    #wget -O "hbase-$HBASE_VERSION-bin.tar.gz" "https://archive.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION-hadoop2-bin.tar.gz" && \
    # HBase 0.98
    wget -O "hbase-$HBASE_VERSION-bin.tar.gz" "http://www.apache.org/dyn/closer.lua?filename=hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-hadoop2-bin.tar.gz&action=download" && \
    # HBase 1.0
    #wget -O "hbase-$HBASE_VERSION-bin.tar.gz" "http://www.apache.org/dyn/closer.lua?filename=hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz&action=download"
    # HBase 1.1+
    #wget -O "hbase-$HBASE_VERSION-bin.tar.gz" "http://www.apache.org/dyn/closer.lua?filename=hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz&action=download" && \
    tar zxvf hbase-$HBASE_VERSION-bin.tar.gz && \
    ln -sv hbase-$HBASE_VERSION hbase && \
    rm -fv hbase-$HBASE_VERSION-bin.tar.gz && \
    rm -fr /hbase/docs /hbase/src && \
    yum remove -y wget tar && \
    yum autoremove -y && \
    yum clean all

COPY entrypoint.sh /
COPY hbase-site.xml /hbase/conf/

# Stargate  8080  / 8085
# Thrift    9090  / 9095
# HMaster   16000 / 16010
# RS        16201 / 16301
EXPOSE 2181 8080 8085 9090 9095 16000 16010 16201 16301

CMD "/entrypoint.sh"
