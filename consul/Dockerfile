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
#  http://www.linkedin.com/in/harisekhon
#

FROM busybox
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG CONSUL_VERSION

ENV PATH $PATH:/

LABEL Description="HashiCorp's Consul minimal" \
      "Consul Version"="$CONSUL_VERSION"

COPY consul /
#COPY entrypoint.sh /

EXPOSE 8400 8500 8600

#ENTRYPOINT ["/entrypoint.sh"]
