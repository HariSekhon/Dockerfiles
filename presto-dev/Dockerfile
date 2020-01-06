#
#  Author: Hari Sekhon
#  Date: 2017-09-13 14:47:23 +0200 (Wed, 13 Sep 2017)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM alpine:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

# cache the std packages between tagged versions for space efficiency, must have this above ARG

# bash   => entrypoint.sh
# java   => presto engine
# python => launcher script
# less   => presto pager
# curl   => ./get_presto_version.sh
RUN set -eux && \
    apk add --no-cache bash openjdk8-jre-base python less

WORKDIR /

ENV PATH $PATH:/presto/bin

ARG PRESTO_VERSION="latest"

LABEL Description="Presto SQL" \
      "Presto SQL Version"="$PRESTO_VERSION"

COPY get_presto_versions.sh /

# hadolint ignore=DL4006
RUN set -eux && \
    TAR="presto-server-${PRESTO_VERSION}.tar.gz" && \
    apk add --no-cache curl wget tar && \
    if [ "$PRESTO_VERSION" = "latest" ]; then \
        # determine latest version automatically - this will be used by DockerHub automated builds but if calling Make it will pre-populate PRESTO_VERSION as part of make build to know the image to push
        PRESTO_VERSION=$(./get_presto_versions.sh | head -n1); \
    fi && \
    server_url="https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz" && \
    cli_url="https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/${PRESTO_VERSION}/presto-cli-${PRESTO_VERSION}-executable.jar" && \
    wget -t 10 --retry-connrefused -O "${TAR}" "$server_url" && \
    test -s "${TAR}" && \
    tar zxf "${TAR}" && \
    # check tarball was extracted to the right place, helps ensure it's the right version and the link will work
    test -d "presto-server-${PRESTO_VERSION}" && \
    rm -fv  "${TAR}" && \
    ln -sv "presto-server-${PRESTO_VERSION}" presto && \
    wget -t 10 --retry-connrefused "$cli_url" && \
    test -s "presto-cli-${PRESTO_VERSION}-executable.jar" && \
    chmod +x "presto-cli-${PRESTO_VERSION}-executable.jar" && \
    mv -v "presto-cli-${PRESTO_VERSION}-executable.jar" presto/bin/ && \
    ln -sv "presto-cli-${PRESTO_VERSION}-executable.jar" presto/bin/presto && \
    rm -v get_presto_versions.sh && \
    apk del curl tar wget

# Add user support not running as root
RUN set -eux && \
    adduser -D presto && \
    mkdir -pv /presto/logs /var/lib/presto && \
    chown -R presto /presto/logs /var/lib/presto

COPY entrypoint.sh /
COPY etc /presto/etc

EXPOSE 8080

CMD ["/entrypoint.sh"]
