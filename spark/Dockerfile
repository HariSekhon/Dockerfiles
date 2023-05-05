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

#FROM harisekhon/centos-java:jre7
# > 100MB smaller than centos
# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM alpine:3.12

ARG SPARK_VERSION=1.6.2
ARG HADOOP_VERSION=2.6

LABEL org.opencontainers.image.description="Apache Spark" \
      org.opencontainers.image.version="$SPARK_VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/spark" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/spark" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

ARG TAR=spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

ENV PATH $PATH:/spark/bin

#COPY spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION /spark
#ADD "http://d3kbcqa49mib13.cloudfront.net/${TAR}"

WORKDIR /

RUN set -eux && \
    apk add --no-cache bash openjdk8-jre-base

RUN set -eux && \
    apk add --no-cache wget tar && \
    wget -t 100 --retry-connrefused -O "${TAR}" "http://d3kbcqa49mib13.cloudfront.net/${TAR}" && \
    tar zxf "${TAR}" && \
    rm -fv "${TAR}" && \
    ln -s "spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION" spark && \
    apk del wget tar

RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd && \
cp -v /spark/conf/spark-env.sh.template /spark/conf/spark-env.sh

COPY entrypoint.sh /

EXPOSE 4040 7077 8080 8081

CMD ["/entrypoint.sh"]
