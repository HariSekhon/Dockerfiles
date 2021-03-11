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

FROM jenkins/inbound-agent:4.6-1
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG JENKINS_AGENT_VERSION=4.6

LABEL Description="Jenkins inbound-agent with Docker command" \
      "Jenkins Version"="$JENKINS_AGENT_VERSION"

USER root

RUN set -eux && \
    apt-get update && \
    apt-get install -y docker.io docker-compose && \
    curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/clean_caches.sh | sh

USER jenkins
