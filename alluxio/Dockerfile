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

ARG ALLUXIO_VERSION=1.8.1

ENV PATH $PATH:/alluxio/bin

LABEL org.opencontainers.image.description="Alluxio by Berkeley AMPLab" \
      org.opencontainers.image.version="$ALLUXIO_VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/alluxio" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/alluxio" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

WORKDIR /

SHELL ["/bin/sh", "-eux", "-c"]

# OpenJDK8 recent versions give error:
#
# org.apache.jasper.JasperException: PWC6033: Error in Javac compilation for JSP PWC6199: Generated servlet error: The type java.io.ObjectInputStream cannot be resolved. It is indirectly referenced from required .class files
#
# use OpenJDK7 instead
#
# needs a full JDK now for master, not just JRE
RUN apk add --no-cache bash openjdk8 sudo

RUN apk add --no-cache wget tar && \
    wget -t 100 --retry-connrefused -O "alluxio-${ALLUXIO_VERSION}-bin.tar.gz" "http://alluxio.org/downloads/files/${ALLUXIO_VERSION}/alluxio-${ALLUXIO_VERSION}-bin.tar.gz" && \
    tar zxf "alluxio-${ALLUXIO_VERSION}-bin.tar.gz" && \
    rm -fv "alluxio-${ALLUXIO_VERSION}-bin.tar.gz" && \
    ln -sv "alluxio-${ALLUXIO_VERSION}" alluxio && \
    cp -v alluxio/conf/alluxio-env.sh.template alluxio/conf/alluxio-env.sh && \
    alluxio format && \
    apk del wget tar

COPY conf/alluxio-site.properties alluxio/conf/
COPY entrypoint.sh /

EXPOSE 19999 30000

ENTRYPOINT ["/entrypoint.sh"]
