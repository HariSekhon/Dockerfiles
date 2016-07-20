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

FROM harisekhon/centos-java:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ENV PATH $PATH:/apache-drill/bin:/zookeeper/bin

LABEL Description="Apache Drill" \
      "Apache Drill Version"="$APACHE_DRILL_VERSION"

RUN \
    # required for supervisord
    yum install -y epel-release && \
    # used by nagios checks
    yum install -y supervisor && \
    yum remove -y epel-release && \
    yum autoremove -y && \
    yum clean all

#ARG APACHE_DRILL_VERSION=0.7.0
#ARG APACHE_DRILL_VERSION=0.8.0
#ARG APACHE_DRILL_VERSION=0.9.0
#ARG APACHE_DRILL_VERSION=1.0.0
#ARG APACHE_DRILL_VERSION=1.1.0
#ARG APACHE_DRILL_VERSION=1.2.0
#ARG APACHE_DRILL_VERSION=1.3.0
#ARG APACHE_DRILL_VERSION=1.4.0
#ARG APACHE_DRILL_VERSION=1.5.0
#ARG APACHE_DRILL_VERSION=1.6.0
ARG APACHE_DRILL_VERSION=1.7.0

ARG TAR=apache-drill-${APACHE_DRILL_VERSION}.tar.gz

ENV DRILL_HEAP=900M

# -e ZOOKEEPER_HOST if clustering these containers with external contained linked zookeeper
ENV ZOOKEEPER_HOST=zookeeper

RUN \
    yum install -y wget tar which && \
    if [ "${APACHE_DRILL_VERSION:0:3}" = "1.6" -o "${APACHE_DRILL_VERSION:0:3}" = "1.7" ]; then \
        url="http://www.apache.org/dyn/closer.lua?filename=drill/drill-${APACHE_DRILL_VERSION}/${TAR}&action=download"; \
    else \
        url="http://archive.apache.org/dist/drill/drill-${APACHE_DRILL_VERSION}/${TAR}"; \
    fi && \
    wget -t 100 --retry-connrefused -O "${TAR}" "$url" && \
    tar xvf "${TAR}" && \
    rm -fv  "${TAR}" && \
    ln -sv "apache-drill-${APACHE_DRILL_VERSION}" apache-drill && \
    yum remove -y wget tar && \
    yum autoremove -y && \
    yum install hostname -y && \
    yum clean all

COPY entrypoint.sh /
COPY supervisord.d/drill.ini /etc/supervisord.d/

EXPOSE 8047

CMD /entrypoint.sh
