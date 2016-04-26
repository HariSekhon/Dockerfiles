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

ARG SERF_VERSION=0.7.0

ENV PATH $PATH:/

LABEL Description="HashiCorp's Serf minimal" \
      "Serf Version"="$SERF_VERSION"

#COPY serf /
#COPY entrypoint.sh /

#ADD https://releases.hashicorp.com/serf/${SERF_VERSION}/serf_${SERF_VERSION}_linux_amd64.zip /

RUN \
    apt-get update && \
    apt-get install -y curl unzip && \
    cd / && \
    curl https://releases.hashicorp.com/serf/${SERF_VERSION}/serf_${SERF_VERSION}_linux_amd64.zip > serf_${SERF_VERSION}_linux_amd64.zip && \
    unzip serf_${SERF_VERSION}_linux_amd64.zip && \
    rm -fv serf_${SERF_VERSION}_linux_amd64.zip && \
    apt-get purge -y curl unzip && \
    apt-get clean

EXPOSE 7946 7373

ENTRYPOINT ["/serf"]
#ENTRYPOINT ["/entrypoint.sh"]
