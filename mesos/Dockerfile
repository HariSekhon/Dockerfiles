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

#FROM harisekhon/centos-java:jre7
# > 100MB smaller than centos
FROM harisekhon/debian-java:jre7
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

#ARG MESOS_VERSION=0.23.0
#ARG MESOS_VERSION=0.24.0
#ARG MESOS_VERSION=0.25.0
ARG MESOS_VERSION=0.26.0
#ARG MESOS_VERSION=0.27.0
#ARG MESOS_VERSION=0.28.0

ENV PATH $PATH:/mesos/bin

LABEL Description="Apache Mesos" \
      "Apache Mesos Version"="$MESOS_VERSION"

WORKDIR /

RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends wget && \
    if   [ "${MESOS_VERSION:0:3}" = "0.23" ]; then url="http://downloads.mesosphere.io/master/debian/8/mesos_$MESOS_VERSION-1.0.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:3}" = "0.24" ]; then url="http://downloads.mesosphere.io/master/debian/8/mesos_$MESOS_VERSION-1.0.33.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:3}" = "0.25" ]; then url="http://downloads.mesosphere.io/master/debian/8/mesos_$MESOS_VERSION-0.2.70.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:3}" = "0.26" ]; then url="http://downloads.mesosphere.io/master/debian/8/mesos_$MESOS_VERSION-0.2.145.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:3}" = "0.27" ]; then url="http://downloads.mesosphere.io/master/debian/8/mesos_$MESOS_VERSION-0.2.190.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:3}" = "0.28" ]; then url="http://repos.mesosphere.com/debian/pool/main/m/mesos/mesos_0.28.0-2.0.16.debian81_amd64.deb"; \
    else echo "unexpected mesos version"; exit 1; fi && \
    wget -t 10 --retry-connrefused "$url" && \
    dpkg -i mesos*.deb; \
    apt-get install -yf && \
    dpkg -i mesos*.deb && \
    apt-get purge -y wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -v mesos*.deb

COPY entrypoint.sh /

EXPOSE 5050 5051

ENTRYPOINT ["/entrypoint.sh"]
