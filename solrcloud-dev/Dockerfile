#
#  Author: Hari Sekhon
#  Date: 2016-05-18 18:10:20 +0100 (Wed, 18 May 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles/solrcloud-dev
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM harisekhon/nagios-plugins:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

# SolrCloud doesn't exist < 4.0 but this is for consistency with dockerfiles_check_git_branches.py validator
# originally I removed the solrcloud directories from these < 4.0 solr branches but this makes merges require manual fixing on every master merge
ARG SOLRCLOUD_VERSION=3.6
#ARG SOLRCLOUD_VERSION=4.10.4
#ARG SOLRCLOUD_VERSION=5.5.2
#ARG SOLRCLOUD_VERSION=6.0.1
#ARG SOLRCLOUD_VERSION=6.1.0
#ARG SOLRCLOUD_VERSION=6.2.1
#ARG SOLRCLOUD_VERSION=6.3.0
#ARG SOLRCLOUD_VERSION=6.4.2
#ARG SOLRCLOUD_VERSION=6.5.1
#ARG SOLRCLOUD_VERSION=6.6.0

ARG TAR="solr-$SOLRCLOUD_VERSION.tgz"

ENV PATH $PATH:/solr/bin

LABEL Description="SolrCloud + Nagios Plugins", \
      "Solr Version"="$SOLRCLOUD_VERSION"

WORKDIR /

RUN apk add --no-cache bash openjdk8-jre-base lsof

RUN \
    apk add --no-cache wget tar && \
    # Solr 4+ only
    url="http://www.apache.org/dyn/closer.lua?filename=lucene/solr/$SOLRCLOUD_VERSION/$TAR&action=download"; \
    url_archive="http://archive.apache.org/dist/lucene/solr/$SOLRCLOUD_VERSION/$TAR"; \
    #for x in {1..10}; do wget -t 10 --retry-connrefused -c -O "$TAR" "$url" && break; done && \
    wget -t 10 --retry-connrefused -O "${TAR}" "$url" || \
    wget -t 10 --retry-connrefused -O "${TAR}" "$url_archive" && \
    tar zxf "$TAR" && \
    ln -sv solr-$SOLRCLOUD_VERSION solr && \
    rm -fv "$TAR" && \
    { rm -rf solr/doc; : ; } && \
    apk del tar wget

COPY entrypoint.sh /
COPY solr-start.sh /

RUN adduser -S -s /bin/bash solr && \
    chown -R solr /solr* && \
    chmod 0555 /entrypoint.sh /solr-start.sh

EXPOSE 8983 8984 9983

ENTRYPOINT ["/entrypoint.sh"]
