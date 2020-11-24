#
#  Author: Hari Sekhon
#  Date: 2016-07-22 14:37:57 +0100 (Fri, 22 Jul 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM jetbrains/teamcity-server:2020.2
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

# used to version tagging by Make build, keep aligned with the FROM above since it can't be used in the FROM directly
ARG TEAMCITY_VERSION=2020.2

ARG MYSQL_CONNECTOR_VERSION=8.0.22

RUN libdir=/opt/teamcity/lib/jdbc && \
    mkdir -v "$libdir" && \
    curl -sSL --fail "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.tar.gz" | \
    tar zxvf - -C "$libdir" --strip 1 "mysql-connector-java-${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar" && \
    ln -s "$libdir/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar" "$libdir/mysql-connector-java.jar"
