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
FROM alpine:3.12

LABEL org.opencontainers.image.description="Spotify Tools" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/spotify-tools" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/spotify-tools" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

ENV PATH $PATH:/github/spotify-tools:/github/spotify-tools/bash-tools

RUN mkdir -v /github

WORKDIR /github

# hadolint ignore=DL3003
RUN set -eux && \
    x=spotify-tools; \
    apk add --no-cache make git && \
    git clone https://github.com/harisekhon/$x /github/$x && \
    cd /github/$x && \
    make build clean && \
    make apk-packages-remove && \
    apk del make git

WORKDIR /github/spotify-tools

# trying to do -exec basename {} \; results in only the jython files being printed
# hadolint ignore=DL3025
CMD find /github/spotify-tools -maxdepth 2 -type f -name '*.pl' -o -type f -name '*.sh' | grep spotify | grep -v old/ | xargs -n1 basename | sort
