#
#  Author: Hari Sekhon
#  Date: 2016-05-18 18:10:20 +0100 (Wed, 18 May 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# not basing on official solr as it doesn't have Solr < 5.0 which I want to keep using for my test suite
# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM alpine:3.12

ARG SOLR_VERSION=7.7.1

ARG TAR="solr-$SOLR_VERSION.tgz"

LABEL org.opencontainers.image.description="Solr" \
      org.opencontainers.image.version="$SOLR_VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/solr" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/solr" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

ENV PATH $PATH:/solr/bin

WORKDIR /

# Solr start script needs jar or unzip to extract war
RUN set -eux && \
    apk add --no-cache bash openjdk8-jre-base

# hadolint ignore=SC2039
RUN set -eux && \
    apk add --no-cache wget tar && \
    # Solr 3.x has a different tarball
    if [ "${SOLR_VERSION:0:1}" = 3 ]; then \
        url="http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/apache-solr-$SOLR_VERSION.tgz"; \
    else \
        url="http://www.apache.org/dyn/closer.lua?filename=lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz&action=download"; \
        url_archive="http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/$TAR"; \
    fi && \
    #for x in {1..10}; do wget -t 10 --retry-connrefused -c -O "$TAR" "$url" && break; done && \
    # --max-redirect - some apache mirrors redirect a couple times and give you the latest version instead
    #                  but this breaks stuff later because the link will not point to the right dir
    #                  (and is also the wrong version for the tag)
    wget -t 10 --max-redirect 1 --retry-connrefused -O "${TAR}" "$url" || \
    wget -t 10 --max-redirect 1 --retry-connrefused -O "${TAR}" "$url_archive" && \
    tar zxf "$TAR" && \
    # normalize apache-solr-3.x => solr-<version> like newer versions
    if [ -d apache-solr-$SOLR_VERSION ]; then mv -iv apache-solr-$SOLR_VERSION solr-$SOLR_VERSION; fi && \
    # check tarball was extracted to the right place, helps ensure it's the right version and the link will work
    test -d "solr-$SOLR_VERSION" && \
    ln -sv "solr-$SOLR_VERSION" solr && \
    rm -fv "$TAR" && \
    { rm -rf solr/doc; : ; } && \
    apk del tar wget

COPY entrypoint.sh /
COPY solr-start.sh /

RUN set -eux && \
    adduser -S -s /bin/bash solr && \
    chown -R solr /solr* && \
    chmod 0555 /entrypoint.sh /solr-start.sh

EXPOSE 8983 8984 9983

ENTRYPOINT ["/entrypoint.sh"]
