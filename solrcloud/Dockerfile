#
#  Author: Hari Sekhon
#  Date: 2016-05-18 18:10:20 +0100 (Wed, 18 May 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

# not basing on official solr as it doesn't have SolrCloud 4.x which I want to keep using for my test suite
FROM harisekhon/debian-java:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

#ARG SOLR_VERSION=4.10.4
ARG SOLR_VERSION=5.5.0
#ARG SOLR_VERSION=6.0.0

ARG TAR="solr-$SOLR_VERSION.tgz"

ENV PATH $PATH:/solr/bin

LABEL Description="SolrCloud", \
      "Solr Version"="$SOLR_VERSION"

WORKDIR /

RUN \
    wget -O "$TAR" "http://www.apache.org/dyn/closer.lua?filename=lucene/solr/${SOLR_VERSION}/solr-$SOLR_VERSION.tgz&action=download" && \
    tar zxvf "$TAR" && \
    ln -sv solr-$SOLR_VERSION solr && \
    rm -fv "$TAR" && \
    rm -fr /solr/doc && \
    yum autoremove -y && \
    yum clean all

COPY entrypoint.sh /

EXPOSE 8983 8984 9983

ENTRYPOINT ["/entrypoint.sh"]
