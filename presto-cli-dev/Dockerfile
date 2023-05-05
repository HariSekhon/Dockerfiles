#
#  Author: Hari Sekhon
#  Date: 2017-09-13 14:47:23 +0200 (Wed, 13 Sep 2017)
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

# cache the std packages between tagged versions for space efficiency, must have this above ARG

# bash   => entrypoint.sh
# java   => presto engine
# python => launcher script
# less   => presto pager
# curl   => ./get_presto_version.sh
RUN set -eux && \
    apk add --no-cache bash openjdk8-jre-base python less

ARG PRESTO_VERSION="latest"

LABEL org.opencontainers.image.description="Presto SQL" \
      org.opencontainers.image.version="$PRESTO_VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/presto-cli-dev" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/presto-cli-dev" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

ENV PATH $PATH:/presto/bin

WORKDIR /

COPY get_presto_versions.sh /

RUN bash -c ' \
    set -euxo pipefail && \
    apk add --no-cache curl wget tar && \
    if [ "$PRESTO_VERSION" = "latest" ]; then \
        # determine latest version automatically - this will be used by DockerHub automated builds but if calling Make it will pre-populate PRESTO_VERSION as part of make build to know the image to push
        set +o pipefail; \
        PRESTO_VERSION=$(./get_presto_versions.sh | head -n1); \
        set -o pipefail; \
    fi && \
    cli_url="https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/${PRESTO_VERSION}/presto-cli-${PRESTO_VERSION}-executable.jar" && \
    wget -t 10 --retry-connrefused "$cli_url" && \
    test -s "presto-cli-${PRESTO_VERSION}-executable.jar" && \
    chmod +x "presto-cli-${PRESTO_VERSION}-executable.jar" && \
    ln -s "/presto-cli-${PRESTO_VERSION}-executable.jar" /usr/bin/presto && \
    rm -v get_presto_versions.sh && \
    apk del curl tar wget \
    '

ENTRYPOINT ["/usr/bin/presto"]
