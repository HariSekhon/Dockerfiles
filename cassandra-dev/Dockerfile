#
#  Author: Hari Sekhon
#  Date: 2016-01-16 09:58:07 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback
#  to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# can't base off Cassandra as it's missing deps to run the tools
# and official Cassandra versions only go back to 2.1 and miss in between versions like 3.5, 3.6 which I still test against
#FROM cassandra:latest
# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM harisekhon/nagios-plugins:alpine

LABEL org.opencontainers.image.description="Cassandra + Dev Tools / Nagios Plugins" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/cassandra-dev" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/cassandra-dev" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

ENV PATH $PATH:/cassandra/bin

ARG CASSANDRA_VERSION=3.11.4

ARG TAR="apache-cassandra-$CASSANDRA_VERSION-bin.tar.gz"

LABEL Description="Cassandra Dev" \
      "Cassandra Version"="$CASSANDRA_VERSION"

WORKDIR /

# java   => cassandra engine
# py-pip => cassandra python driver
RUN set -eux && \
    apk add --no-cache openjdk8-jre-base py-pip

# hadolint ignore=DL3013
RUN set -eux && \
    apk add --no-cache wget && \
    url="http://www.apache.org/dyn/closer.lua?filename=cassandra/$CASSANDRA_VERSION/$TAR&action=download"; \
    url_archive="http://archive.apache.org/dist/cassandra/$CASSANDRA_VERSION/$TAR"; \
    # --max-redirect - some apache mirrors redirect a couple times and give you the latest version instead
    #                  but this breaks stuff later because the link will not point to the right dir
    #                  (and is also the wrong version for the tag)
    wget -t 10 --max-redirect 1 --retry-connrefused -O "$TAR" "$url" || \
    wget -t 10 --max-redirect 1 --retry-connrefused -O "$TAR" "$url_archive" && \
    tar zxf "$TAR" && \
    rm -fv  "$TAR" && \
    # check tarball was extracted to the right place, helps ensure it's the right version and the link will work
    test -d "apache-cassandra-$CASSANDRA_VERSION" && \
    ln -sv "apache-cassandra-$CASSANDRA_VERSION" cassandra && \
    rm -rf cassandra/doc cassandra/javadoc && \
    pip install --upgrade cassandra-driver cql && \
    apk del wget

# cassandra refuses to run as root without -R, just run as regular useraddgroup -S cassandra id=501 && adduser -S -G cassandra --uid=501 cassandra && \
RUN set -eux && \
    adduser -D -u 501 cassandra && \
    mkdir /var/lib/cassandra /var/log/cassandra && \
    chown -R cassandra "apache-cassandra-${CASSANDRA_VERSION}" /home/cassandra /var/lib/cassandra /var/log/cassandra && \
    sed -i 's,cassandra:/bin/false,cassandra:/bin/bash,' /etc/passwd && \
    sed -i 's/-Xss180k/-Xss228k/' cassandra/conf/cassandra-env.sh && \
    sed -i 's/^rpc_address:/#rpc_address:/' cassandra/conf/cassandra.yaml && \
    sed -i 's/^#[[:space:]]*rpc_interface:.*/rpc_interface: eth0/' cassandra/conf/cassandra.yaml

# 7000: intra-node communication
# 7001: TLS intra-node communication
# 7199: JMX
# 9042: CQL
# 9160: thrift service
EXPOSE 7000 7001 7199 9042 9160

COPY entrypoint.sh /

CMD ["/entrypoint.sh"]
