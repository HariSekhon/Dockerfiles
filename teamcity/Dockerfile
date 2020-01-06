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

FROM harisekhon/centos-java:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG TEAMCITY_VERSION=10.0
ARG TAR="TeamCity-$TEAMCITY_VERSION.tar.gz"

ENV PATH $PATH:/opt/TeamCity/bin

LABEL Description="TeamCity" \
      "TeamCity Version"="$TEAMCITY_VERSION"

WORKDIR /opt

RUN set -eux && \
    yum install -y tar && \
    curl -L "https://download.jetbrains.com/teamcity/$TAR" > "$TAR" && \
    tar zxf "$TAR" && \
    # fails as it tries to remove systemd
    #yum remove -y tar && \
    yum autoremove -y && \
    yum clean all && \
    rm -rf /var/cache/yum

EXPOSE 8111

CMD ["teamcity-server.sh", "start"]
