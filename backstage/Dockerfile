#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2021-07-08 15:16:50 +0100 (Thu, 08 Jul 2021)
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# This huge monolith app beast is unfortunately not really designed for the Cloud-native Kubernetes era:
#
# - not really modular / microservices
# - takes ~15 minutes to build!
# - fails to build on a 2GB local Docker Desktop, had to increase to 4GB!

# Based off https://backstage.io/docs/deployment/docker#multi-stage-build
#
# but improved to be more cloud suitable self-contained and not use locally staged repo

# ============================================================================ #
# Stage 1 - Create yarn install skeleton layer
# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM node:14-buster-slim AS packages

# XXX: set this to change the release version
ARG RELEASE="2021-07-08"

# only change this if the URL changes in future or you want to pull from another source, eg. an internal staging area
ARG RELEASE_URL="https://github.com/backstage/backstage/archive/refs/tags/release-$RELEASE.tar.gz"

WORKDIR /app

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3015
RUN apt-get update && \
    apt-get install -y curl && \
    curl -sSL "$RELEASE_URL" | tar zxv --strip-components=1
    # doc removes these package.json but this breaks the cli dependency in the next stage during yarn tsc:
    #
    # tsconfig.json(2,14): error TS6053: File '@backstage/cli/config/tsconfig.json' not found.
    #
    #find packages \! -name "package.json" -mindepth 2 -maxdepth 2 -exec rm -rf {} \+
    #
    #rm -rf microsite  # 60 out of 100MB we probably don't need including an mp4

# ============================================================================ #
# Stage 2 - Install dependencies and build packages
# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM node:14-buster-slim AS build

WORKDIR /app

COPY --from=packages /app .

RUN yarn install --frozen-lockfile --network-timeout 600000 && rm -rf "$(yarn cache dir)"

# '--jsx preserve' avoids a tonne of errors that exceed the 1MiB docker log and mask later breaking errors
RUN yarn tsc --jsx preserve
RUn yarn --cwd packages/backend backstage-cli backend:bundle --build-dependencies

# ============================================================================ #
# Stage 3 - Build the actual backend image and install production dependencies

# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM node:14-buster-slim

ARG RELEASE=2021-07-08

#ENV PATH $PATH:/NAME/bin

LABEL org.opencontainers.image.description="Backstage Developer Portal" \
      org.opencontainers.image.version="$RELEASE" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/backstage" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/backstage" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

WORKDIR /app

# Copy the install dependencies from the build stage and context
# ADD doesn't have --from feature
# hadolint ignore=DL3010
COPY --from=build /app/yarn.lock /app/package.json /app/packages/backend/dist/skeleton.tar.gz ./
RUN tar xzf skeleton.tar.gz && rm skeleton.tar.gz

RUN yarn install --frozen-lockfile --production --network-timeout 600000 && rm -rf "$(yarn cache dir)"

# Copy the built packages from the build stage
# ADD doesn't have --from feature
# hadolint ignore=DL3010
COPY --from=build /app/packages/backend/dist/bundle.tar.gz .
RUN tar xzf bundle.tar.gz && rm bundle.tar.gz

# contains boilerplate for all sorts of integrations which fail
#COPY --from=build /app/app-config.yaml ./
# commented out version
COPY app-config.yaml ./

EXPOSE 7000

CMD ["node", "packages/backend", "--config", "app-config.yaml"]
