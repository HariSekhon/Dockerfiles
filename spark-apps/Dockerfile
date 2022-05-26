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
FROM harisekhon/centos-scala:2.11-jdk8

LABEL org.opencontainers.image.description="Spark Scala Apps (Spark => Elasticsearch etc)" \
      org.opencontainers.image.version="$VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/spark-apps" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/spark-apps" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

# unit test for lib-java fails when sh is found in /usr/bin/sh as /usr/bin is earlier in the path than /bin
ENV PATH /bin:$PATH:/github/spark-apps

RUN mkdir -vp /github

WORKDIR /github

# hadolint ignore=DL3003
RUN bash -c ' \
    set -euxo pipefail && \
    x=spark-apps; \
    yum install -y make git maven && \
    curl -L https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo && \
    yum install -y --nogpgcheck sbt && \
    git clone https://github.com/harisekhon/$x /github/$x && \
    cd /github/$x && \
    make build clean && \
    yum autoremove -y && \
    yum clean all && \
    rm -rf /var/cache/yum \
    '

WORKDIR /github/spark-apps

CMD ["/bin/bash"]
