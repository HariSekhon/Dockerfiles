#
#  Author: Hari Sekhon
#  Date: 2016-04-24 21:18:57 +0100 (Sun, 24 Apr 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles/hbase
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback
#
#  https://www.linkedin.com/in/harisekhon
#

FROM alpine:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

#ARG HBASE_VERSION=0.94.27
#ARG HBASE_VERSION=0.96.2
#ARG HBASE_VERSION=0.98.24
#ARG HBASE_VERSION=1.0.3
#ARG HBASE_VERSION=1.1.9
#ARG HBASE_VERSION=1.2.6
ARG HBASE_VERSION=1.3.1

ENV PATH $PATH:/hbase/bin

ENV JAVA_HOME=/usr

LABEL Description="HBase Dev", \
      "HBase Version"="$HBASE_VERSION"

WORKDIR /

RUN apk add --no-cache bash openjdk8-jre-base

RUN apk add --no-cache wget tar && \
    # HBase 0.94
    if   [ "${HBASE_VERSION:0:4}" = "0.94" ]; then \
        url="http://www.apache.org/dyn/closer.lua?filename=hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION.tar.gz&action=download"; \
        url_archive="http://archive.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION.tar.gz"; \
    # HBase 0.96 usually missing from mirrors, have to use apache archive
    elif [ "${HBASE_VERSION:0:4}" = "0.96" ]; then \
        url="https://archive.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION-hadoop2-bin.tar.gz"; \
        url_archive="http://archive.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION-hadoop2-bin.tar.gz"; \
    # HBase 0.98
    elif [ "${HBASE_VERSION:0:4}" = "0.98" ]; then \
        url="http://www.apache.org/dyn/closer.lua?filename=hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-hadoop2-bin.tar.gz&action=download"; \
        url_archive="http://archive.apache.org/dist/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-hadoop2-bin.tar.gz"; \
    # HBase 1.0
    elif [ "${HBASE_VERSION:0:3}" = "1.0"  ]; then \
        url="http://www.apache.org/dyn/closer.lua?filename=hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz&action=download"; \
        url_archive="http://archive.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz"; \
    # HBase 1.1+
    elif [ "${HBASE_VERSION:0:1}" = "1"    ]; then \
        url="http://www.apache.org/dyn/closer.lua?filename=hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz&action=download"; \
        url_archive="http://archive.apache.org/dist/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz"; \
    else \
        echo "unrecognized HBase version"; exit 1; \
    fi && \
    wget -t 10 --retry-connrefused -O "hbase-$HBASE_VERSION-bin.tar.gz" "$url" || \
    wget -t 10 --retry-connrefused -O "hbase-$HBASE_VERSION-bin.tar.gz" "$url_archive" && \
    mkdir hbase-$HBASE_VERSION && \
    tar zxf hbase-$HBASE_VERSION-bin.tar.gz -C hbase-$HBASE_VERSION --strip 1 && \
    ln -sv hbase-$HBASE_VERSION hbase && \
    rm -fv hbase-$HBASE_VERSION-bin.tar.gz && \
    { rm -rf hbase/{docs,src}; : ; } && \
    apk del wget tar

COPY entrypoint.sh /
COPY conf/hbase-site.xml /hbase/conf/
COPY profile.d/java.sh /etc/profile.d/

# Stargate  8080  / 8085
# Thrift    9090  / 9095
# HMaster   16000 / 16010
# RS        16201 / 16301
EXPOSE 2181 8080 8085 9090 9095 16000 16010 16201 16301

CMD "/entrypoint.sh"
