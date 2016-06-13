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

ARG MESOS_VERSION=0.23.0
#ARG MESOS_VERSION=0.24.2
#ARG MESOS_VERSION=0.25.1
#ARG MESOS_VERSION=0.26.1
#ARG MESOS_VERSION=0.27.2
#ARG MESOS_VERSION=0.28.2

#ARG TAR="mesos-$MESOS_VERSION.tar.gz"

ENV PATH $PATH:/mesos/bin

LABEL Description="Apache Mesos" \
      "Apache Mesos Version"="$MESOS_VERSION"

WORKDIR /

RUN \
    # debian uses sh -c by default which doesn't recognize the ${var:n:n}
    bash -c '\
    apt-get update && \
    # Apache only ships source, don't want entire dev tooling in image
    #apt-get install -y --no-install-recommends tar wget && \
    #wget -t 10 --retry-connrefused "http://archive.apache.org/dist/mesos/$MESOS_VERSION/$TAR" && \
    #tar zxvf "$TAR" && \
    #rm -v "$TAR" && \
    #ln -sf "mesos-$MESOS_VERSION" mesos && \
    apt-get install -y --no-install-recommends wget && \
    if   [ "${MESOS_VERSION:0:4}" = "0.23" ]; then url="http://downloads.mesosphere.io/master/debian/8/mesos_$MESOS_VERSION-1.0.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:4}" = "0.24" ]; then url="http://downloads.mesosphere.io/master/debian/8/mesos_$MESOS_VERSION-1.0.33.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:4}" = "0.25" ]; then url="http://downloads.mesosphere.io/master/debian/8/mesos_$MESOS_VERSION-0.2.70.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:4}" = "0.26" ]; then url="http://downloads.mesosphere.io/master/debian/8/mesos_$MESOS_VERSION-0.2.145.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:4}" = "0.27" ]; then url="http://downloads.mesosphere.io/master/debian/8/mesos_$MESOS_VERSION-0.2.190.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:4}" = "0.28" ]; then url="http://repos.mesosphere.com/debian/pool/main/m/mesos/mesos_$MESOS_VERSION-2.0.16.debian81_amd64.deb"; \
    else echo "unexpected mesos version"; exit 1; fi && \
    wget -t 10 --retry-connrefused "$url" && \
    dpkg -i mesos*.deb; \
    apt-get install -yf && \
    dpkg -i mesos*.deb && \
    # attempting to remove tar causes unmet dependency breakage
    apt-get purge -y wget && \
    apt-get autoremove -y && \
    apt-get clean'

COPY entrypoint.sh /

EXPOSE 5050 5051

ENTRYPOINT ["/entrypoint.sh"]
