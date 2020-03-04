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

# -dev version allows testing of local consul command utils like check_consul_version.py

# busybox wget doesn't support SSL, no curl available :-(
#FROM busybox:latest
# Alpine keeps breaking stuff, even after adding libc6-compat:
# Error relocating ./consul: __fprintf_chk: symbol not foundError relocating ./consul: __fprintf_chk: symbol not found
# rather than downloading glibc with a tonne of extra commands, just switch to debian
#FROM harisekhon/alpine-github:latest
FROM harisekhon/centos-github:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG CONSUL_VERSION=1.4.2

ENV PATH $PATH:/

LABEL Description="HashiCorp's Consul + Dev tools" \
      "Consul Version"="$CONSUL_VERSION"

WORKDIR /

# faster, cached
#COPY consul /

#ADD https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip

RUN set -eux && \
    yum install -y wget unzip net-tools && \
    wget -t 100 --retry-connrefused -O "consul_${CONSUL_VERSION}_linux_amd64.zip" "https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip" && \
    unzip "consul_${CONSUL_VERSION}_linux_amd64.zip" && \
    rm -fv "consul_${CONSUL_VERSION}_linux_amd64.zip" && \
    yum remove -y wget unzip && \
    yum autoremove -y && \
    yum clean all && \
    rm -rf /var/cache/yum

#COPY entrypoint.sh /

EXPOSE 8400 8500 8600

CMD ["/consul", "agent", "-dev", "-data-dir", "/tmp", "-client", "0.0.0.0"]
