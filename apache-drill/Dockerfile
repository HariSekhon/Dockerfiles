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

ARG APACHE_DRILL_VERSION=1.17.0

LABEL org.opencontainers.image.description="Apache Drill distributed SQL engine" \
      org.opencontainers.image.version="$APACHE_DRILL_VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/apache-drill" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/apache-drill" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

ARG TAR=apache-drill-${APACHE_DRILL_VERSION}.tar.gz

ENV DRILL_HEAP=900M

# -e ZOOKEEPER_HOST if clustering these containers with external contained linked zookeeper
ENV ZOOKEEPER_HOST=zookeeper

ENV PATH $PATH:/apache-drill/bin:/zookeeper/bin

LABEL Description="Apache Drill" \
      "Apache Drill Version"="$APACHE_DRILL_VERSION"

WORKDIR /

# bash       => entrypoint.sh
# java       => apache drill engine
# supervisor => drillbit standalone runner for nagios checks
# which      => drill-embedded script
RUN set -eux && \
    apk add --no-cache bash openjdk8 supervisor which && \
    mkdir -p /etc/supervisor.d

RUN set -eux && \
    apk add --no-cache wget tar && \
    url="http://www.apache.org/dyn/closer.lua?filename=drill/drill-${APACHE_DRILL_VERSION}/${TAR}&action=download"; \
    url_archive="http://archive.apache.org/dist/drill/drill-${APACHE_DRILL_VERSION}/${TAR}"; \
    # --max-redirect - some apache mirrors redirect a couple times and give you the latest version instead
    #                  but this breaks stuff later because the link will not point to the right dir
    #                  (and is also the wrong version for the tag)
    wget -t 10 --max-redirect 1 --retry-connrefused -O "${TAR}" "$url" || \
    wget -t 10 --max-redirect 1 --retry-connrefused -O "${TAR}" "$url_archive" && \
    tar zxf "${TAR}" && \
    # check tarball was extracted to the right place, helps ensure it's the right version and the link will work
    test -d "apache-drill-${APACHE_DRILL_VERSION}" && \
    rm -fv  "${TAR}" && \
    ln -sv "apache-drill-${APACHE_DRILL_VERSION}" apache-drill && \
    apk del tar wget

# need to keep this here to make it easier to launch supervisor with just a ZOOKEEPER_HOST and DRILL_HEAP environment variables
# hadolint ignore=SC1117
RUN set -eux && \
    # for older versions
    sed -i -e "s/-Xms1G/-Xms\$DRILL_MAX_HEAP/" apache-drill/conf/drill-env.sh && \
    sed -i -e "s/^DRILL_MAX_HEAP=.*/DRILL_MAX_HEAP=\"${DRILL_HEAP}\"/" apache-drill/conf/drill-env.sh && \
    \
    sed -i -e "s/^DRILL_HEAP=.*/DRILL_HEAP=\"${DRILL_HEAP}\"/" apache-drill/conf/drill-env.sh && \
    sed -i -e "s/^\([[:space:]]*\)zk.connect:.*/\\1zk.connect: \"${ZOOKEEPER_HOST}\"/" apache-drill/conf/drill-override.conf

COPY entrypoint.sh /
COPY supervisord.d/drill.ini /etc/supervisor.d/

EXPOSE 8047

CMD ["/entrypoint.sh"]
