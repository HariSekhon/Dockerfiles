#
#  Author: Hari Sekhon
#  Date: 2022-06-20 15:09:03 +0100 (Mon, 20 Jun 2022)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# ============================================================================ #
#                                   T F e n v
# ============================================================================ #

# https://github.com/tfutils/tfenv

# Loads the Terraform version dynamically at runtime
#
# pass TFENV_TERRAFORM_VERSION when running the container, otherwise will default to downloading the latest version of Terraform

# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM alpine:3.12

LABEL org.opencontainers.image.description="TFenv for Terraform" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/tfenv" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/tfenv" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

SHELL ["/bin/sh", "-eux", "-c"]

ENV OWNER_REPO="tfutils/tfenv"

# entrypoint.sh will override this is TERRAFORM_VERSION is set
ENV TFENV_TERRAFORM_VERSION=latest

ENV TFENV_AUTO_INSTALL=true

ENV USER=tfenv

ENV PATH "/home/$USER/.tfenv/bin:$PATH"

# git  - needed to clone tfenv
# curl - needed for tfenv to list and install versions
RUN apk add --no-cache \
    bash \
    git \
    curl

RUN adduser -D "$USER"

USER "$USER"

# bust cache from here on any new commits
ADD https://api.github.com/repos/$OWNER_REPO/git/refs/heads/master /.git-hashref

RUN git clone https://github.com/$OWNER_REPO.git ~/.tfenv

# do at runtime
#RUN tfenv install

COPY entrypoint.sh /

SHELL ["/bin/bash"]

# 'terraform' is wrapped by tfenv and will automatically install the right version before running the command
ENTRYPOINT ["/entrypoint.sh"]
