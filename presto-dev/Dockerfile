#
#  Author: Hari Sekhon
#  Date: 2017-09-13 14:47:23 +0200 (Wed, 13 Sep 2017)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM alpine:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG PRESTO_VERSION=0.184

ARG TAR="presto-server-${PRESTO_VERSION}.tar.gz"

ENV PATH $PATH:/presto/bin

LABEL Description="Presto SQL" \
      "Presto SQL Version"="$PRESTO_VERSION"

WORKDIR /

# bash   => entrypoint.sh
# java   => presto engine
# python => launcher script
# less   => presto pager
RUN set -euxo pipefail && \
    apk add --no-cache bash openjdk8-jre-base python less

RUN set -euxo pipefail && \
    apk add --no-cache wget tar && \
    server_url="https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz" && \
    cli_url="https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/0.184/presto-cli-${PRESTO_VERSION}-executable.jar" && \
    wget -t 10 --retry-connrefused -O "${TAR}" "$server_url" && \
    wget -t 10 --retry-connrefused "$cli_url" && \
    test -s "${TAR}" && \
    tar zxf "${TAR}" && \
    # check tarball was extracted to the right place, helps ensure it's the right version and the link will work
    test -d "presto-server-${PRESTO_VERSION}" && \
    rm -fv  "${TAR}" && \
    ln -sv "presto-server-${PRESTO_VERSION}" presto && \
    test -s "presto-cli-${PRESTO_VERSION}-executable.jar" && \
    chmod +x "presto-cli-${PRESTO_VERSION}-executable.jar" && \
    mv -v "presto-cli-${PRESTO_VERSION}-executable.jar" presto/bin/ && \
    ln -sv "presto-cli-${PRESTO_VERSION}-executable.jar" presto/bin/presto && \
    apk del tar wget

COPY entrypoint.sh /
COPY etc /presto/etc

EXPOSE 8080

CMD /entrypoint.sh
