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

FROM alpine:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG ALLUXIO_VERSION=1.1.0

ENV PATH $PATH:/alluxio/bin

LABEL Description="Alluxio by Berkeley AMPlab" \
      "Alluxio Version"="$ALLUXIO_VERSION"

WORKDIR /

# OpenJDK8 recent versions give error:
#
# org.apache.jasper.JasperException: PWC6033: Error in Javac compilation for JSP PWC6199: Generated servlet error: The type java.io.ObjectInputStream cannot be resolved. It is indirectly referenced from required .class files
#
# use OpenJDK7 instead
RUN set -euxo pipefail && \
    apk add --no-cache bash openjdk7-jre-base sudo

RUN set -euxo pipefail && \
    apk add --no-cache wget tar && \
    wget -t 100 --retry-connrefused -O "alluxio-${ALLUXIO_VERSION}-bin.tar.gz" "http://alluxio.org/downloads/files/${ALLUXIO_VERSION}/alluxio-${ALLUXIO_VERSION}-bin.tar.gz" && \
    tar zxf "alluxio-${ALLUXIO_VERSION}-bin.tar.gz" && \
    rm -fv "alluxio-${ALLUXIO_VERSION}-bin.tar.gz" && \
    ln -sv "alluxio-${ALLUXIO_VERSION}" alluxio && \
    cp -v alluxio/conf/alluxio-env.sh.template alluxio/conf/alluxio-env.sh && \
    alluxio format && \
    apk del wget tar

COPY entrypoint.sh /

EXPOSE 19999 30000

ENTRYPOINT ["/entrypoint.sh"]
