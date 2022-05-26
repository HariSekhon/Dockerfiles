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

ARG SCALA_VERSION=2.11
ARG KAFKA_VERSION=0.9.0.1
# 0.10 fails to come up
#ARG KAFKA_VERSION=0.10.0.0

LABEL org.opencontainers.image.description="Apache Kafka by LinkedIn" \
      org.opencontainers.image.version="${KAFKA_VERSION}_$SCALA_VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/kafka" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/kafka" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

ENV ADVERTISED_HOSTNAME=127.0.0.1

ENV PATH $PATH:/kafka/bin

ENV TAR="kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"

# bash => entrypoint.sh
# perl => entrypoint.sh kafka configs in place edit for advertised hostname
# java => kafka
RUN set -eux && \
    apk add --no-cache bash perl openjdk8-jre-base

RUN set -eux && \
    apk add --no-cache tar wget && \
    wget -t 10 --retry-connrefused -O "$TAR" "https://www.apache.org/dyn/closer.cgi?filename=/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz&action=download" || \
    wget -t 10 --retry-connrefused -O "$TAR" "http://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" && \
    tar zxf "kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" && \
    rm -fv "kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" && \
    ln -sv "kafka_${SCALA_VERSION}-${KAFKA_VERSION}" kafka && \
    apk del tar wget

COPY entrypoint.sh /

EXPOSE 2181 9092

CMD ["/entrypoint.sh"]
