#
#  Author: Hari Sekhon
#  Date: 2020-03-18 14:47:30 +0000 (Wed, 18 Mar 2020)
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
FROM debian:9

LABEL org.opencontainers.image.description="AppVeyor BYOC Agent" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/appveyor" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/appveyor" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

ENV DEBIAN_FRONTEND=noninteractive

RUN bash -c ' \
    set -euxo pipefail && \
    apt-get update && \
    apt-get install -y curl && \
    curl -sS https://raw.githubusercontent.com/HariSekhon/DevOps-Bash-tools/master/install/install_powershell_debian.sh | bash && \
    curl -sS https://raw.githubusercontent.com/HariSekhon/DevOps-Bash-tools/master/install/install_appveyor_byoc.sh | bash && \
    curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/bin/clean_caches.sh | sh \
    '

COPY entrypoint.sh /

WORKDIR /opt/appveyor/host-agent

CMD ["/entrypoint.sh"]
