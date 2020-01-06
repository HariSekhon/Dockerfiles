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

# 'jython -m ensurepip' to install pip results in this on openjdk:jdk-alpine:
# NotImplementedError: passwd.pw_passwd unimplemented
# so instead use Debian based openjdk normal image
FROM openjdk:8
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Jython $JYTHON_VERSION on OpenJDK, with pip, jip and mock"

ARG JYTHON_VERSION=2.7.0
ARG JYTHON_HOME=/opt/jython-$JYTHON_VERSION

ENV JYTHON_VERSION=$JYTHON_VERSION
ENV JYTHON_HOME=$JYTHON_HOME
ENV PATH=$PATH:$JYTHON_HOME/bin

RUN bash -c ' \
    set -euxo pipefail && \
    apt-get update && \
    apt-get install -y wget && \
    wget -cO jython-installer.jar "http://search.maven.org/remotecontent?filepath=org/python/jython-installer/$JYTHON_VERSION/jython-installer-$JYTHON_VERSION.jar" && \
    java -jar jython-installer.jar -s -t standard -d "$JYTHON_HOME" && \
    jython -m pip install jip mock && \
    rm -f jython-installer.jar && \
    ln -sfv "$JYTHON_HOME/bin/"* /usr/local/bin/ && \
    apt-get purge -y wget \
    '

#CMD ["bash"]
CMD ["jython"]
