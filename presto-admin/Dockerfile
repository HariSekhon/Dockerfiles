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
FROM centos:7

ARG PRESTO_ADMIN_VERSION=2.3

LABEL org.opencontainers.image.description="Presto Admin" \
      org.opencontainers.image.version="$PRESTO_ADMIN_VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/presto-admin" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/presto-admin" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

ARG TAR="prestoadmin-${PRESTO_ADMIN_VERSION}-online.tar.gz"

ENV PATH $PATH:/prestoadmin/bin

WORKDIR /

# bash   => entrypoint.sh
# java   => presto engine
# python => presto admin
RUN set -eux && \
    #yum install -y bash java-1.8.0-openjdk-headless python
    # pycrypto # resolves to python2-crypto
    yum install -y bash python && \
    yum clean all && \
    rm -rf /var/cache/yum

# hadolint ignore=DL3003
RUN set -eux && \
    yum install -y gcc python-devel tar wget && \
    url="https://github.com/prestodb/presto-admin/releases/download/$PRESTO_ADMIN_VERSION/$TAR" && \
    wget -t 10 --retry-connrefused -O "${TAR}" "$url" && \
    test -s "${TAR}" && \
    tar zxf "${TAR}" && \
    ls -l && \
    rm -fv  "${TAR}" && \
    cd prestoadmin && \
    ./install-prestoadmin.sh && \
    # trying to remove tar tries to remove systemd
    yum remove -y gcc python-devel wget && \
    yum autoremove -y && \
    rm -rf /var/cache/yum

#EXPOSE 8080

#CMD /entrypoint.sh
