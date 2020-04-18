#
#  Author: Hari Sekhon
#  Date: 2016-12-23 10:03:26 +0000 (Fri, 23 Dec 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM rabbitmq:3.8
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG RABBITMQ_VERSION=3.8

LABEL Description="RabbitMQ Cluster" \
      "RabbitMQ Version"="$RABBITMQ_VERSION"

COPY entrypoint.sh /
COPY rabbitmq-cluster /

EXPOSE 15672

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/rabbitmq-cluster"]
