#
#  Author: Hari Sekhon
#  Date: 2016-01-16 09:58:07 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles/nifi
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM alpine:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ENV PATH $PATH:/nifi/bin

#ARG NIFI_VERSION=0.5.1
ARG NIFI_VERSION=0.6.1
#ARG NIFI_VERSION=0.7.0
#ARG NIFI_VERSION=1.0.0

ARG TAR=nifi-${NIFI_VERSION}-bin.tar.gz

LABEL Description="Nifi" \
      "Nifi Version"="$NIFI_VERSION"

WORKDIR /

RUN \
    apk update && \
    apk add bash openjdk8-jre-base wget tar && \
    #if [ "${NIFI_VERSION:0:3}" = "0.7" ]; then \
    #    url="http://www.apache.org/dyn/closer.lua?filename=nifi/${NIFI_VERSION}/${TAR}&action=download"; \
    #else \
        url="http://archive.apache.org/dist/nifi/${NIFI_VERSION}/${TAR}"; \
    #fi && \
    wget -t 100 --retry-connrefused -O "${TAR}" "$url" && \
    tar zxf "${TAR}" && \
    rm -fv  "${TAR}" && \
    ln -sv "nifi-${NIFI_VERSION}" nifi && \
    #{ rm -rf nifi/docs; : ; } && \
    apk del wget tar

EXPOSE 8080

CMD nifi.sh start; tail -f /nifi/log*/*
