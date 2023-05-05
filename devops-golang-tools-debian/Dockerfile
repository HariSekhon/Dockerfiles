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
FROM debian:11 as builder

LABEL org.opencontainers.image.description="Golang Tools" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/go-tools" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/go-tools" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

# used by build.sh to figure out which repo to bootstrap
ENV PATH $PATH:/github/go-tools/bin

ADD https://raw.githubusercontent.com/HariSekhon/DevOps-Bash-tools/master/setup/docker_bootstrap.sh /build.sh

RUN chmod +x /build.sh && NO_TESTS=1 /build.sh

# gets error:
# bash: ./uniq2: No such file or directory
#FROM bash
# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM debian:11

ENV PATH $PATH:/github/go-tools/bin

COPY --from=builder /github/go-tools/bin/colors     /github/go-tools/bin/
COPY --from=builder /github/go-tools/bin/httpfirst  /github/go-tools/bin/
COPY --from=builder /github/go-tools/bin/uniq2      /github/go-tools/bin/
COPY --from=builder /github/go-tools/bin/welcome    /github/go-tools/bin/

CMD ["/bin/bash", "-c", "find /github/go-tools/bin -maxdepth 1 -type f | xargs -n1 basename | sort"]
