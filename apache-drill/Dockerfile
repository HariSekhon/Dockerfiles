#
#  Author: Hari Sekhon
#  Date: 2016-01-16 09:58:07 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles/apache-drill
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM alpine:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ENV PATH $PATH:/apache-drill/bin:/zookeeper/bin

LABEL Description="Apache Drill" \
      "Apache Drill Version"="$APACHE_DRILL_VERSION"

RUN \
    apk update && \
    # used by nagios checks
    apk add supervisor && \
    mkdir -p /etc/supervisor.d

#ARG APACHE_DRILL_VERSION=0.7.0
#ARG APACHE_DRILL_VERSION=0.8.0
#ARG APACHE_DRILL_VERSION=0.9.0
#ARG APACHE_DRILL_VERSION=1.0.0
#ARG APACHE_DRILL_VERSION=1.1.0
#ARG APACHE_DRILL_VERSION=1.2.0
#ARG APACHE_DRILL_VERSION=1.3.0
#ARG APACHE_DRILL_VERSION=1.4.0
ARG APACHE_DRILL_VERSION=1.5.0
#ARG APACHE_DRILL_VERSION=1.6.0
#ARG APACHE_DRILL_VERSION=1.7.0
#ARG APACHE_DRILL_VERSION=1.8.0

ARG TAR=apache-drill-${APACHE_DRILL_VERSION}.tar.gz

ENV DRILL_HEAP=900M

# -e ZOOKEEPER_HOST if clustering these containers with external contained linked zookeeper
ENV ZOOKEEPER_HOST=zookeeper

WORKDIR /

RUN \
    apk update && \
    apk add bash openjdk8-jre-base which wget tar && \
    if [ "${APACHE_DRILL_VERSION:0:3}" = "1.7" -o \
         "${APACHE_DRILL_VERSION:0:3}" = "1.8" ]; then \
        url="http://www.apache.org/dyn/closer.lua?filename=drill/drill-${APACHE_DRILL_VERSION}/${TAR}&action=download"; \
    else \
        url="http://archive.apache.org/dist/drill/drill-${APACHE_DRILL_VERSION}/${TAR}"; \
    fi && \
    wget -t 100 --retry-connrefused -O "${TAR}" "$url" && \
    tar zxf "${TAR}" && \
    rm -fv  "${TAR}" && \
    ln -sv "apache-drill-${APACHE_DRILL_VERSION}" apache-drill && \
    apk del wget tar

# need to keep this here to make it easier to launch supervisor with just a ZOOKEEPER_HOST and DRILL_HEAP environment variables
RUN \
    # for older versions
    sed -i -e "s/-Xms1G/-Xms\$DRILL_MAX_HEAP/" apache-drill/conf/drill-env.sh; \
    sed -i -e "s/^DRILL_MAX_HEAP=.*/DRILL_MAX_HEAP=\"${DRILL_HEAP}\"/" apache-drill/conf/drill-env.sh; \
    \
    sed -i -e "s/^DRILL_HEAP=.*/DRILL_HEAP=\"${DRILL_HEAP}\"/" apache-drill/conf/drill-env.sh; \
    sed -i -e "s/^\([[:space:]]*\)zk.connect:.*/\\1zk.connect: \"${ZOOKEEPER_HOST}\"/" apache-drill/conf/drill-override.conf

COPY entrypoint.sh /
COPY supervisord.d/drill.ini /etc/supervisor.d/

EXPOSE 8047

CMD /entrypoint.sh
