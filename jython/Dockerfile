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

FROM openjdk:jre-alpine
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG JYTHON_VERSION=2.7.0
ARG JYTHON_HOME=/opt/jython-$JYTHON_VERSION

ENV JYTHON_VERSION=$JYTHON_VERSION
ENV JYTHON_HOME=$JYTHON_HOME
ENV PATH=$PATH:$JYTHON_HOME/bin

LABEL Description="Jython $JYTHON_VERSION on Alpine + OpenJDK, minimal container"

RUN set -eux && \
    apk add --no-cache bash

RUN set -eux && \
    apk add --no-cache wget && \
    wget -cO jython-installer.jar "http://search.maven.org/remotecontent?filepath=org/python/jython-installer/$JYTHON_VERSION/jython-installer-$JYTHON_VERSION.jar" && \
    java -jar jython-installer.jar -s -t minimum -d "$JYTHON_HOME" && \
    rm -fr "$JYTHON_HOME"/Docs "$JYTHON_HOME"/Demo "$JYTHON_HOME"/tests && \
    rm -f jython-installer.jar && \
    ln -sfv "$JYTHON_HOME/bin/"* /usr/local/bin/ && \
    apk del wget

#CMD ["jython"]
ENTRYPOINT ["jython"]
