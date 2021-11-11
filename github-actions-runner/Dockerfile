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
#  https://www.linkedin.com/in/harisekhon
#

FROM ubuntu:20.04
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG GITHUB_ACTIONS_RUNNER_VERSION=2.284.0

ENV PATH $PATH:/actions-runner

ENV DEBIAN_FRONTEND noninteractive

LABEL Description="GitHub Actions Runner" \
      "GitHub Actions Runner Version"="$GITHUB_ACTIONS_RUNNER_VERSION"

# creates and cd's to this dir
WORKDIR /actions-runner

RUN set -eux && \
    apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl sudo && \
    curl -Lo actions-runner.tar.gz "https://github.com/actions/runner/releases/download/v$GITHUB_ACTIONS_RUNNER_VERSION/actions-runner-linux-x64-$GITHUB_ACTIONS_RUNNER_VERSION.tar.gz" && \
    tar zxvf actions-runner.tar.gz && \
    rm -f actions-runner.tar.gz && \
    useradd actions-runner && \
    echo "actions-runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    cd /actions-runner && \
    bin/installdependencies.sh && \
    chown -R actions-runner /actions-runner && \
    curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/clean_caches.sh | sh

# adds nearly 500MB to the image size
#run set -eux && \
#    apt-get update && \
#    apt-get install -y docker.io && \
#    curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/clean_caches.sh | sh

USER actions-runner

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
