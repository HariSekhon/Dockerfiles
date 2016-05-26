#
#  Author: Hari Sekhon
#  Date: 2016-01-16 09:58:07 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM harisekhon/centos-java:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ENV PATH $PATH:/apache-drill/bin

LABEL Description="Apache Drill" \
      "Apache Drill Version"="$DRILL_VERSION"

RUN \
    # required for supervisord
    yum install -y epel-release && \
    # used by nagios checks
    yum install -y supervisor && \
    yum remove -y epel-release && \
    yum autoremove -y && \
    yum clean all

#ARG DRILL_VERSION=0.7.0
#ARG DRILL_VERSION=0.8.0
#ARG DRILL_VERSION=0.9.0
ARG DRILL_VERSION=1.0.0
#ARG DRILL_VERSION=1.1.0
#ARG DRILL_VERSION=1.2.0
#ARG DRILL_VERSION=1.3.0
#ARG DRILL_VERSION=1.4.0
#ARG DRILL_VERSION=1.5.0
#ARG DRILL_VERSION=1.6.0

ARG DRILL_HEAP=900M
ARG TAR=apache-drill-${DRILL_VERSION}.tar.gz
# zookeeper hostname embedded in configuration file for distributed cluster - use this name in container linking
ARG ZOOKEEPER_HOST=zookeeper

RUN \
    yum install -y wget tar && \
    if   [ "${DRILL_VERSION:0:3}" = "1.5" -o "${DRILL_VERSION:0:3}" = "1.6" ]; then url="http://www.apache.org/dyn/closer.lua?filename=drill/drill-${DRILL_VERSION}/${TAR}&action=download"; \
    else url="http://archive.apache.org/dist/drill/drill-${DRILL_VERSION}/${TAR}"; \
    fi && \
    wget -O "${TAR}" "$url" && \
    tar xvf "${TAR}" && \
    rm -fv  "${TAR}" && \
    ln -sv "apache-drill-${DRILL_VERSION}" apache-drill && \
    sed -i -e "s/^DRILL_HEAP=\".+\"/DRILL_HEAP=\"${DRILL_HEAP}\"/" "apache-drill-${DRILL_VERSION}/conf/drill-env.sh" && \
    sed -i -e "s/^\([[:space:]]*\)zk.connect:.*/\\1zk.connect: \"${ZOOKEEPER_HOST}\"/" "apache-drill-${DRILL_VERSION}/conf/drill-override.conf" && \
    yum remove -y wget tar && \
    yum autoremove -y && \
    yum install hostname -y && \
    yum clean all

COPY drill.ini /etc/supervisord.d/

EXPOSE 8047

# for daemon do
#CMD /usr/bin/supervisord -n
CMD /apache-drill/bin/drill-embedded
