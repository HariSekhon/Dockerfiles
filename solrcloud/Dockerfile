#
#  Author: Hari Sekhon
#  Date: 2016-05-18 18:10:20 +0100 (Wed, 18 May 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles/solrcloud
#
#  If you're using my code you're welcome to connect with me on LinkedIn
#  and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

# not basing on official solr as it doesn't have SolrCloud 4.x which I want to keep using for my test suite
FROM alpine:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG SOLRCLOUD_VERSION=4.10.4
#ARG SOLRCLOUD_VERSION=5.5.2
#ARG SOLRCLOUD_VERSION=6.0.1
#ARG SOLRCLOUD_VERSION=6.1.0
#ARG SOLRCLOUD_VERSION=6.2.0

ARG TAR="solr-$SOLRCLOUD_VERSION.tgz"

ENV PATH $PATH:/solr/bin

LABEL Description="SolrCloud", \
      "Solr Version"="$SOLRCLOUD_VERSION"

WORKDIR /

RUN \
    apk update && \
    # SolrCloud solr -e cloud asks for lsof to detect if something is listening on 8983
    apk add bash openjdk8-jre-base lsof wget tar && \
    # Solr 4.x
    # no longer on mirrors, use Apache archive instead
    #if [ "${SOLRCLOUD_VERSION:0:1}" = "4" ]; then url="http://archive.apache.org/dist/lucene/solr/$SOLRCLOUD_VERSION/solr-$SOLRCLOUD_VERSION.tgz"; \
    #elif [ "${SOLRCLOUD_VERSION:0:1}" = "6" -a "${SOLRCLOUD_VERSION:2:1}" -lt 2 ]; then url="http://archive.apache.org/dist/lucene/solr/$SOLRCLOUD_VERSION/$TAR"; \
    #else url="http://www.apache.org/dyn/closer.lua?filename=lucene/solr/$SOLRCLOUD_VERSION/$TAR&action=download"; \
    #fi && \
    url="http://archive.apache.org/dist/lucene/solr/$SOLRCLOUD_VERSION/$TAR"; \
    for x in {1..10}; do wget -t 10 --retry-connrefused -c -O "$TAR" "$url" && break; done && \
    tar zxf "$TAR" && \
    ln -sv solr-$SOLRCLOUD_VERSION solr && \
    rm -fv "$TAR" && \
    { rm -rf solr/doc; : ; } && \
    apk del wget tar

COPY entrypoint.sh /

EXPOSE 8983 8984 9983

ENTRYPOINT ["/entrypoint.sh"]
