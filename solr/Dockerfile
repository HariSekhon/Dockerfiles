#
#  Author: Hari Sekhon
#  Date: 2016-05-18 18:10:20 +0100 (Wed, 18 May 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles/solr
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

# not basing on official solr as it doesn't have Solr < 5.0 which I want to keep using for my test suite
FROM alpine:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

#ARG SOLR_VERSION=3.1.0
#ARG SOLR_VERSION=3.6.2
#ARG SOLR_VERSION=4.10.4
#ARG SOLR_VERSION=5.5.2
#ARG SOLR_VERSION=6.0.1
#ARG SOLR_VERSION=6.1.0
#ARG SOLR_VERSION=6.2.1
#ARG SOLR_VERSION=6.3.0
#ARG SOLR_VERSION=6.4.2
ARG SOLR_VERSION=6.5.1

ARG TAR="solr-$SOLR_VERSION.tgz"

ENV PATH $PATH:/solr/bin

LABEL Description="Solr", \
      "Solr Version"="$SOLR_VERSION"

WORKDIR /

RUN \
    # SolrCloud solr -e cloud asks for lsof to detect if something is listening on 8983
    # Solr start script needs jar or unzip to extract war
    apk add --no-cache bash openjdk8-jre-base lsof wget tar && \
    # Solr 3.x / 4.x
    # no longer on mirrors, use Apache archive instead
    if [ "${SOLR_VERSION:0:1}" = 3 ]; then url="http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/apache-solr-$SOLR_VERSION.tgz"; \
    #elif [ "${SOLR_VERSION:0:1}" = 4 ]; then url="http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz"; \
    #elif [ "${SOLR_VERSION:0:1}" = "6" -a "${SOLR_VERSION:2:1}" -lt 2 ]; then url="http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz"; \
    #else url="http://www.apache.org/dyn/closer.lua?filename=lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz&action=download"; \
    else url="http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/$TAR"; \
    fi && \
    for x in {1..10}; do wget -t 10 --retry-connrefused -c -O "$TAR" "$url" && break; done && \
    tar zxf "$TAR" && \
    # normalize apache-solr-3.x => solr-<version> like newer versions
    if [ -d apache-solr-$SOLR_VERSION ]; then mv -iv apache-solr-$SOLR_VERSION solr-$SOLR_VERSION; fi && \
    ln -sv solr-$SOLR_VERSION solr && \
    rm -fv "$TAR" && \
    { rm -rf solr/doc; : ; } && \
    apk del wget tar

COPY entrypoint.sh /

EXPOSE 8983 8984 9983

ENTRYPOINT ["/entrypoint.sh"]
