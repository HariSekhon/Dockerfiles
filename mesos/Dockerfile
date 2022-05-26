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

#FROM harisekhon/centos-java:jre7
# > 100MB smaller than centos
# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM harisekhon/debian-java:jre7

ARG MESOS_VERSION=0.28.2

LABEL org.opencontainers.image.description="Apache Mesos" \
      org.opencontainers.image.version="$MESOS_VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/mesos" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/mesos" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

#ARG TAR="mesos-$MESOS_VERSION.tar.gz"

ENV DEBIAN_FRONTEND noninteractive

ENV PATH $PATH:/mesos/bin

WORKDIR /

# debian uses sh -c by default which doesn't recognize the ${var:n:n}
RUN bash -c '\
    set -euxo pipefail && \
    apt-get update && \
    # need net-tools for ifconfig in /entrypoint.sh
    apt-get install -y --no-install-recommends wget net-tools && \
    # Apache only ships source, don't want entire dev tooling in image
    #apt-get install -y --no-install-recommends tar wget && \
    #wget -t 10 --retry-connrefused "http://archive.apache.org/dist/mesos/$MESOS_VERSION/$TAR" && \
    #tar zxvf "$TAR" && \
    #rm -v "$TAR" && \
    #ln -sf "mesos-$MESOS_VERSION" mesos && \
    #
    # doesn't take past release version suffixes and repo is non-browseable (MESOS-5608)
#    apt-get install -y --no-install-recommends lsb-release && \
#    apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
#    DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]') && \
#    CODENAME=$(lsb_release -cs) && \
#    echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | tee /etc/apt/sources.list.d/mesosphere.list && \
#    apt-get update && \
#
    if   [ "${MESOS_VERSION:0:4}" = "0.23" ]; then file="mesos_$MESOS_VERSION-1.0.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:4}" = "0.24" ]; then file="mesos_$MESOS_VERSION-2.0.17.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:4}" = "0.25" ]; then file="mesos_$MESOS_VERSION-2.0.21.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:4}" = "0.26" ]; then file="mesos_$MESOS_VERSION-2.0.19.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:4}" = "0.27" ]; then file="mesos_$MESOS_VERSION-2.0.15.debian81_amd64.deb"; \
    elif [ "${MESOS_VERSION:0:4}" = "0.28" ]; then file="mesos_$MESOS_VERSION-2.0.27.debian81_amd64.deb"; \
    else echo "unexpected mesos version"; exit 1; fi && \
    wget -t 10 --retry-connrefused "http://repos.mesosphere.com/debian/pool/main/m/mesos/$file" && \
    #apt-get install ./mesos*.deb && \
    dpkg -i mesos*.deb || :; \
    apt-get install -yf && \
    dpkg -i mesos*.deb && \
    # attempting to remove tar causes unmet dependency breakage
    apt-get purge -y wget && \
    apt-get autoremove -y && \
    apt-get clean'

COPY entrypoint.sh /

EXPOSE 5050 5051

ENTRYPOINT ["/entrypoint.sh"]
