#
#  Author: Hari Sekhon
#  Date: 2016-01-16 09:58:07 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM alpine:3.12

ARG ZOOKEEPER_VERSION=3.4.13

LABEL org.opencontainers.image.description="ZooKeeper " \
      org.opencontainers.image.version="$ZOOKEEPER_VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/zookeeper" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/zookeeper" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

ARG TAR=zookeeper-${ZOOKEEPER_VERSION}.tar.gz

ENV PATH $PATH:/zookeeper/bin

WORKDIR /

# bash => entrypoint.sh
# java => zookeeper
RUN set -eux && \
    apk add --no-cache bash openjdk8-jre-base

RUN set -eux && \
    apk add --no-cache wget tar && \
    url="http://www.apache.org/dyn/closer.lua?filename=zookeeper/zookeeper-${ZOOKEEPER_VERSION}/${TAR}&action=download" && \
    url_archive="http://archive.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/${TAR}" && \
    wget -t 5 --retry-connrefused -O "$TAR" "$url" || \
    wget -t 5 --retry-connrefused -O "$TAR" "$url_archive" && \
    tar zxf "${TAR}" && \
    rm -fv "${TAR}" && \
    ln -sv /zookeeper-${ZOOKEEPER_VERSION} /zookeeper && \
    cp -av /zookeeper/conf/zoo_sample.cfg /zookeeper/conf/zoo.cfg && \
    rm -rf zookeeper/src zookeeper/docs && \
    apk del wget tar

EXPOSE 2181 3181 4181

COPY entrypoint.sh /

CMD ["/entrypoint.sh"]
