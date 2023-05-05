#
#  Author: Hari Sekhon
#  Date: 2016-04-24 21:18:57 +0100 (Sun, 24 Apr 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback
#
#  https://www.linkedin.com/in/HariSekhon
#

# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM harisekhon/alpine-java:jre8

ARG HBASE_VERSION=2.1.3

LABEL org.opencontainers.image.description="HBase" \
      org.opencontainers.image.version="$HBASE_VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/hbase" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/hbase" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

ENV PATH $PATH:/hbase/bin

ENV JAVA_HOME=/usr

WORKDIR /

# bash - needed for entrypoint.sh
RUN apk add --no-cache bash

# hadolint ignore=SC2039
RUN set -eux && \
    apk add --no-cache wget tar && \
    # older versions have to use apache archive
    # HBase 0.90, 0.92, 0.94
    if  [ "${HBASE_VERSION:0:4}" = "0.90" ] || \
        [ "${HBASE_VERSION:0:4}" = "0.92" ] || \
        [ "${HBASE_VERSION:0:4}" = "0.94" ]; then \
        url="http://www.apache.org/dyn/closer.lua?filename=hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION.tar.gz&action=download"; \
        url_archive="http://archive.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION.tar.gz"; \
    # HBase 0.95 / 0.96
    elif [ "${HBASE_VERSION:0:4}" = "0.95" ] || \
         [ "${HBASE_VERSION:0:4}" = "0.96" ]; then \
        url="https://archive.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION-hadoop2-bin.tar.gz"; \
        url_archive="http://archive.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION-hadoop2-bin.tar.gz"; \
    # HBase 0.98
    elif [ "${HBASE_VERSION:0:4}" = "0.98" ]; then \
        url="http://www.apache.org/dyn/closer.lua?filename=hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-hadoop2-bin.tar.gz&action=download"; \
        url_archive="http://archive.apache.org/dist/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-hadoop2-bin.tar.gz"; \
    # HBase 0.99 / 1.0
    elif [ "${HBASE_VERSION:0:4}" = "0.99" ] || \
         [ "${HBASE_VERSION:0:3}" = "1.0" ]; then \
        url="http://www.apache.org/dyn/closer.lua?filename=hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz&action=download"; \
        url_archive="http://archive.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz"; \
    # HBase 1.1+
    else \
        url="http://www.apache.org/dyn/closer.lua?filename=hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz&action=download"; \
        url_archive="http://archive.apache.org/dist/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz"; \
    fi && \
    # --max-redirect - some apache mirrors redirect a couple times and give you the latest version instead
    #                  but this breaks stuff later because the link will not point to the right dir
    #                  (and is also the wrong version for the tag)
    wget -t 10 --max-redirect 1 --retry-connrefused -O "hbase-$HBASE_VERSION-bin.tar.gz" "$url" || \
    wget -t 10 --max-redirect 1 --retry-connrefused -O "hbase-$HBASE_VERSION-bin.tar.gz" "$url_archive" && \
    mkdir "hbase-$HBASE_VERSION" && \
    tar zxf "hbase-$HBASE_VERSION-bin.tar.gz" -C "hbase-$HBASE_VERSION" --strip 1 && \
    test -d "hbase-$HBASE_VERSION" && \
    ln -sv "hbase-$HBASE_VERSION" hbase && \
    rm -fv "hbase-$HBASE_VERSION-bin.tar.gz" && \
    rm -rf hbase/docs hbase/src && \
    mkdir /hbase-data && \
    apk del tar wget

# Needed for HBase 2.0+ hbase-shell
# asciidoctor solves 'NotImplementedError: fstat unimplemented unsupported or native support failed to load'
RUN bash -c ' \
    set -euxo pipefail && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add --no-cache jruby jruby-irb asciidoctor && \
    echo exit | hbase shell \
    # jruby-maven jruby-minitest jruby-rdoc jruby-rake jruby-testunit && \
    '

VOLUME /hbase-data

COPY entrypoint.sh /
COPY conf/hbase-site.xml /hbase/conf/
COPY profile.d/java.sh /etc/profile.d/

# Stargate  8080  / 8085
# Thrift    9090  / 9095
# HMaster   16000 / 16010
# RS        16201 / 16301
EXPOSE 2181 8080 8085 9090 9095 16000 16010 16030 16201 16301

ENTRYPOINT ["/entrypoint.sh"]
