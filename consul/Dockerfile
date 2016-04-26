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
#FROM busybox
FROM debian
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG CONSUL_VERSION=0.6.3

ENV PATH $PATH:/

LABEL Description="HashiCorp's Consul minimal" \
      "Consul Version"="$CONSUL_VERSION"

# faster, cached
#COPY consul /

#ADD https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip

RUN \
    apt-get update && \
    apt-get install -y curl unzip && \
    cd / && \
    curl -L "https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip" > "/consul_${CONSUL_VERSION}_linux_amd64.zip" && \
    unzip "consul_${CONSUL_VERSION}_linux_amd64.zip" && \
    rm -fv "consul_${CONSUL_VERSION}_linux_amd64.zip" && \
    apt-get purge -y curl unzip && \
    apt-get autoremove -y && \
    apt-get clean

#COPY entrypoint.sh /

EXPOSE 8400 8500 8600

#ENTRYPOINT ["/entrypoint.sh"]
ENTRYPOINT ["/consul"]
