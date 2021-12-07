#
#  Author: Hari Sekhon
#  Date: 2021-12-06 16:44:16 +0000 (Mon, 06 Dec 2021)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

# running kustomize command breaks horribly on 'kustomize edit', even 'kustomize version' hangs - even with gcompat - probaby due to musl vs libc
#FROM alpine/git:v2.32.0
#FROM ubuntu:20.04
FROM debian:10-slim  # a little smaller image
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Git + Kustomize minimal docker image"

ENV DEBIAN_FRONTEND noninteractive

ARG KUSTOMIZE_VERSION=4.4.1
ARG GIT_KUSTOMIZE_VERSION=4.4.1  # workaround for hooks/post_build

WORKDIR /

RUN bash -c 'set -euxo pipefail && \
    apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl git openssh-client && \
    curl -Lo /tmp/kustomize.tgz "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz" && \
    tar zxvf /tmp/kustomize.tgz kustomize -O > /usr/local/bin/kustomize && \
    rm -v /tmp/kustomize.tgz && \
    chmod -v +x /usr/local/bin/kustomize && \
    apt-get purge -y curl && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -fr /var/lib/apt/lists && \
    git version && \
    kustomize version'  # check kustomize executes ok

ENTRYPOINT ["/bin/bash"]
