#
#  Author: Hari Sekhon
#  Date: 2016-12-23 10:03:26 +0000 (Fri, 23 Dec 2016)
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
FROM rabbitmq:3.8

ARG RABBITMQ_VERSION=3.8

LABEL org.opencontainers.image.description="RabbitMQ Cluster" \
      org.opencontainers.image.version="$RABBITMQ_VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/rabbitmq-cluster" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/rabbitmq-cluster" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

COPY entrypoint.sh /
COPY rabbitmq-cluster /

EXPOSE 15672

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/rabbitmq-cluster"]
