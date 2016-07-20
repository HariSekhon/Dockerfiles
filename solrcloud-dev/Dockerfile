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

FROM harisekhon/centos-github
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

#ARG SOLRCLOUD_VERSION=4.10.4
#ARG SOLRCLOUD_VERSION=5.5.2
#ARG SOLRCLOUD_VERSION=6.0.1
ARG SOLRCLOUD_VERSION=6.1.0

ARG TAR="solr-$SOLRCLOUD_VERSION.tgz"

ENV PATH $PATH:/solr/bin

LABEL Description="SolrCloud", \
      "Solr Version"="$SOLRCLOUD_VERSION"

WORKDIR /

RUN \
    # Solr 4.x
    # no longer on mirrors, use Apache archive instead
    if [ "${SOLRCLOUD_VERSION:0:1}" = 4 ]; then url="http://archive.apache.org/dist/lucene/solr/$SOLRCLOUD_VERSION/solr-$SOLRCLOUD_VERSION.tgz"; \
    elif [ "${SOLRCLOUD_VERSION:0:3}" = "6.0" ]; then url="http://archive.apache.org/dist/lucene/solr/$SOLRCLOUD_VERSION/solr-$SOLRCLOUD_VERSION.tgz"; \
    else url="http://www.apache.org/dyn/closer.lua?filename=lucene/solr/$SOLRCLOUD_VERSION/solr-$SOLRCLOUD_VERSION.tgz&action=download"; \
    fi && \
    for((i=0;i<10;i++)); do wget -t 10 --retry-connrefused -c -O "$TAR" "$url" && break; done && \
    tar zxvf "$TAR" && \
    ln -sv solr-$SOLRCLOUD_VERSION solr && \
    rm -fv "$TAR" && \
    rm -rf /solr/doc && \
    yum autoremove -y && \
    yum clean all

COPY entrypoint.sh /

EXPOSE 8983 8984 9983

ENTRYPOINT ["/entrypoint.sh"]
