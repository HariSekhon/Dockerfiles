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
#FROM busybox
# Alpine keeps breaking stuff, even after adding libc6-compat:
# Error relocating ./consul: __fprintf_chk: symbol not foundError relocating ./consul: __fprintf_chk: symbol not found
# rather than downloading glibc with a tonne of extra commands, just switch to debian
#FROM alpine
# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM debian:11

ARG CONSUL_VERSION=1.4.2

ENV PATH $PATH:/

LABEL org.opencontainers.image.description="HashiCorp's Consul minimal" \
      org.opencontainers.image.version="$CONSUL_VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/consul" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/consul" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

# faster, cached
#COPY consul /

#ADD https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip

RUN bash -c ' \
    set -euxo pipefail && \
    #apk add --no-cache wget unzip ca-certificates && \
    apt-get update && \
    apt-get install -y wget unzip net-tools && \
    wget -t 100 --retry-connrefused -O "consul_${CONSUL_VERSION}_linux_amd64.zip" "https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip" && \
    unzip "consul_${CONSUL_VERSION}_linux_amd64.zip" && \
    rm -fv "consul_${CONSUL_VERSION}_linux_amd64.zip" && \
    chmod +x consul && \
    ls -l && \
    #apk del wget unzip ca-certificates
    apt-get purge -y wget unzip && \
    apt-get autoremove -y && \
    apt-get clean \
    '

#COPY entrypoint.sh /

EXPOSE 8400 8500 8600

#ENTRYPOINT ["/entrypoint.sh"]
ENTRYPOINT ["/consul"]
