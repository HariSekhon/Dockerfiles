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

ENV PATH $PATH:/nifi/bin

ARG NIFI_VERSION=1.9.0

ARG TAR=nifi-${NIFI_VERSION}-bin.tar.gz

LABEL Description="Nifi" \
      "Nifi Version"="$NIFI_VERSION"

WORKDIR /

RUN set -eux && \
    apk add --no-cache bash openjdk8-jre-base

RUN set -eux && \
    apk add --no-cache wget tar && \
    url="http://www.apache.org/dyn/closer.lua?filename=nifi/${NIFI_VERSION}/${TAR}&action=download"; \
    url_archive="http://archive.apache.org/dist/nifi/${NIFI_VERSION}/${TAR}"; \
    # --max-redirect - some apache mirrors redirect a couple times and give you the latest version instead
    #                  but this breaks stuff later because the link will not point to the right dir
    #                  (and is also the wrong version for the tag)
    wget -t 10 --max-redirect 1 --retry-connrefused -O "${TAR}" "$url" || \
    wget -t 10 --max-redirect 1 --retry-connrefused -O "${TAR}" "$url_archive" && \
    tar zxf "${TAR}" && \
    # check tarball was extracted to the right place, helps ensure it's the right version and the link will work
    test -d "nifi-$NIFI_VERSION" && \
    ln -sv "nifi-${NIFI_VERSION}" nifi && \
    rm -fv  "${TAR}" && \
    #{ rm -rf nifi/docs; : ; } && \
    apk del tar wget

EXPOSE 8080

CMD ["bash", "-c", "nifi.sh start; tail -f /dev/null /nifi/log*/*"]
