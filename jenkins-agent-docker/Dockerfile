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

# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM jenkins/inbound-agent:4.6-1

ARG JENKINS_AGENT_VERSION=4.6

LABEL org.opencontainers.image.description="Jenkins inbound-agent with Docker command" \
      org.opencontainers.image.version="$JENKINS_AGENT_VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/jenkins-agent-docker" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/jenkins-agent-docker" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

USER root

# hadolint ignore=DL3008,DL3015
RUN apt-get update && \
    apt-get install -y docker.io docker-compose && \
    curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/bin/clean_caches.sh | sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash"]

USER jenkins
