#
#  Author: Hari Sekhon
#  Date: 2016-04-24 21:18:57 +0100 (Sun, 24 Apr 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback
#
#  https://www.linkedin.com/in/harisekhon
#

FROM harisekhon/centos-dev
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG HBASE_VERSION=1.2.1

ENV PATH $PATH:/hbase/bin

LABEL Description="HBase Dev", \
      "HBase Version"="$HBASE_VERSION"

WORKDIR /

RUN \
    wget -O "hbase-$HBASE_VERSION-bin.tar.gz" "http://mirrors.ukfast.co.uk/sites/ftp.apache.org/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz" && \
    tar zxvf hbase-$HBASE_VERSION-bin.tar.gz && \
    ln -sv hbase-$HBASE_VERSION hbase && \
    rm -fv hbase-$HBASE_VERSION-bin.tar.gz

# tries to run zookeepers.sh distributed via SSH, run manually in entrypoint.sh now
#RUN sed -i 's/# export HBASE_MANAGES_ZK=true/export HBASE_MANAGES_ZK=true/' /hbase/conf/hbase-env.sh
COPY entrypoint.sh /
COPY hbase-site.xml /hbase/conf/

EXPOSE 60000 60010 60020 60030 20550 8085 9090 9095 60001 60002 60011 60012 60021 60022 60031 60032

CMD "/entrypoint.sh"
