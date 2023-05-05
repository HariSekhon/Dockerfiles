#
#  Author: Hari Sekhon
#  Date: 2016-07-22 14:37:57 +0100 (Fri, 22 Jul 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM jetbrains/teamcity-server:2020.2

# used to version tagging by Make build, keep aligned with the FROM above since it can't be used in the FROM directly
ARG TEAMCITY_VERSION=2020.2

ARG MYSQL_CONNECTOR_VERSION=8.0.22
ARG POSTGRESQL_CONNECTOR_VERSION=42.2.18

LABEL org.opencontainers.image.description="TeamCity" \
      org.opencontainers.image.version="$TEAMCITY_VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/teamcity" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/teamcity" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

# XXX: this directory gets replaced / covered over, this build isn't necessary any more
ENV JDBCDIR=/data/teamcity_server/datadir/lib/jdbc/

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

WORKDIR ${JDBCDIR}

RUN curl -sSL "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.tar.gz" | \
    tar zxvf - --strip 1 "mysql-connector-java-${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar" && \
    ln -sfv "mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar" "mysql-connector-java.jar"

RUN curl -sS "https://jdbc.postgresql.org/download/postgresql-${POSTGRESQL_CONNECTOR_VERSION}.jar" > "postgresql-${POSTGRESQL_CONNECTOR_VERSION}.jar" && \
    ln -sfv "postgresql-${POSTGRESQL_CONNECTOR_VERSION}.jar" "postgresql.jar"

WORKDIR /
