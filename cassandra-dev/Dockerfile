#
#  Author: Hari Sekhon
#  Date: 2016-01-16 09:58:07 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles/cassandra-dev
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback
#  to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

# can't base off Cassandra as it's missing deps to run the tools
# and official Cassandra versions only go back to 2.1 and miss in between versions like 3.5, 3.6 which I still test against
#FROM cassandra:latest
FROM harisekhon/nagios-plugins:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ENV PATH $PATH:/cassandra/bin

#ARG CASSANDRA_VERSION=1.2.9
#ARG CASSANDRA_VERSION=2.0.9
#ARG CASSANDRA_VERSION=2.1.14
ARG CASSANDRA_VERSION=2.2.6
#ARG CASSANDRA_VERSION=3.0.8
#ARG CASSANDRA_VERSION=3.5
#ARG CASSANDRA_VERSION=3.6
#ARG CASSANDRA_VERSION=3.7

ARG TAR="apache-cassandra-$CASSANDRA_VERSION-bin.tar.gz"

LABEL Description="Cassandra Dev", \
      "Cassandra Version"="$CASSANDRA_VERSION"

WORKDIR /

RUN \
    apk add --no-cache wget openjdk8-jre-base && \
    if [ "${CASSANDRA_VERSION:0:3}" = "3.7" ]; then \
        url="http://www.apache.org/dyn/closer.lua?filename=cassandra/$CASSANDRA_VERSION/$TAR&action=download"; \
    else \
        url="http://archive.apache.org/dist/cassandra/${CASSANDRA_VERSION}/${TAR}"; \
    fi && \
    wget -t 100 --retry-connrefused -O "$TAR" "$url" && \
    tar zxf "${TAR}" && \
    rm -fv  "${TAR}" && \
    ln -sv "apache-cassandra-${CASSANDRA_VERSION}" cassandra && \
    { rm -rf cassandra/{doc,javadoc}; : ; } && \
    apk del wget

# cassandra refuses to run as root without -R, just run as regular useraddgroup -S cassandra id=501 && adduser -S -G cassandra --uid=501 cassandra && \
RUN \
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

CMD /entrypoint.sh
