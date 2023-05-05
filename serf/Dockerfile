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

# busybox wget doesn't support SSL, no curl available :-(
#FROM busybox:latest
# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM alpine:3.12

ARG SERF_VERSION=0.8.2

LABEL org.opencontainers.image.description="HashiCorp's Serf minimal" \
      org.opencontainers.image.version="$SERF_VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/serf" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/serf" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

ENV PATH $PATH:/

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
