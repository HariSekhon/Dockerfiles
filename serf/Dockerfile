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

# busybox wget doesn't support SSL, no curl available :-(
#FROM busybox:latest
FROM alpine:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG SERF_VERSION=0.8.2

ENV PATH $PATH:/

LABEL Description="HashiCorp's Serf minimal" \
      "Serf Version"="$SERF_VERSION"

#COPY serf /

#ADD https://releases.hashicorp.com/serf/${SERF_VERSION}/serf_${SERF_VERSION}_linux_amd64.zip /

WORKDIR /

RUN set -eux && \
    apk add --no-cache wget unzip ca-certificates && \
    wget -t 100 --retry-connrefused -O "serf_${SERF_VERSION}_linux_amd64.zip" "https://releases.hashicorp.com/serf/${SERF_VERSION}/serf_${SERF_VERSION}_linux_amd64.zip" && \
    unzip "serf_${SERF_VERSION}_linux_amd64.zip" && \
    rm -fv "serf_${SERF_VERSION}_linux_amd64.zip" && \
    apk del wget unzip ca-certificates

EXPOSE 7946 7373

#COPY entrypoint.sh /

ENTRYPOINT ["/serf"]
#ENTRYPOINT ["/entrypoint.sh"]
