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

# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM ubuntu:20.04

ARG GITHUB_ACTIONS_RUNNER_VERSION=2.284.0

LABEL org.opencontainers.image.description="GitHub Actions Runner" \
      org.opencontainers.image.version="$GITHUB_ACTIONS_RUNNER_VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/github-actions-runner" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/github-actions-runner" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

ENV PATH $PATH:/actions-runner

ENV DEBIAN_FRONTEND noninteractive

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

# creates and cd's to this dir
WORKDIR /actions-runner

# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl sudo && \
    curl -Lo actions-runner.tar.gz "https://github.com/actions/runner/releases/download/v$GITHUB_ACTIONS_RUNNER_VERSION/actions-runner-linux-x64-$GITHUB_ACTIONS_RUNNER_VERSION.tar.gz" && \
    tar zxvf actions-runner.tar.gz && \
    rm -f actions-runner.tar.gz && \
    useradd actions-runner && \
    echo "actions-runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    bin/installdependencies.sh && \
    chown -R actions-runner /actions-runner && \
    curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/bin/clean_caches.sh | sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# adds nearly 500MB to the image size
#run apt-get update && \
#    apt-get install -y docker.io && \
#    curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/bin/clean_caches.sh | sh

SHELL ["/bin/bash"]

USER actions-runner

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
