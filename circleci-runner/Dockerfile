#
#  Author: Hari Sekhon
#  Date: 2021-11-05 03:37:37 +0000 (Fri, 05 Nov 2021)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# Ubuntu based image, so apt-get install dependencies

# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM circleci/runner:launch-agent

LABEL org.opencontainers.image.description="CircleCI Runner" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/circleci-runner" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/circleci-runner" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

ENV DEBIAN_FRONTEND noninteractive

LABEL Description="CircleCI Runner"

USER root

RUN bash -c ' \
    set -euxo pipefail && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        make \
        python3 \
        && \
    curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/bin/clean_caches.sh | sh \
    '

USER circleci

# adds nearly 500MB to the image size
#run set -eux && \
#    apt-get update && \
#    apt-get install -y docker.io && \
#    curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/bin/clean_caches.sh | sh
