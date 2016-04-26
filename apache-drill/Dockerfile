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

FROM harisekhon/centos-dev
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG DRILL_VERSION=1.6.0
ARG DRILL_HEAP=900M
ARG TAR=apache-drill-${DRILL_VERSION}.tar.gz
# use this name in container linking
ARG ZOOKEEPER_HOST=zookeeper

ENV PATH $PATH:/apache-drill/bin

LABEL Description="Apache Drill" \
      "Apache Drill Version"="$DRILL_VERSION"

# faster cached
#COPY apache-drill-$DRILL_VERSION /apache-drill
#COPY drill.ini /etc/supervisord.d/

RUN \
    curl -L "http://www.apache.org/dyn/closer.lua?filename=drill/drill-${DRILL_VERSION}/${TAR}&action=download" > "${TAR}" && \
    tar zxvf "${TAR}" && \
    rm -fv "${TAR}" && \
    ln -sv "apache-drill-${DRILL_VERSION}" apache-drill && \
    perl -pi -e "s/^DRILL_HEAP=\".+\"/DRILL_HEAP=\"${DRILL_HEAP}\"/" "apache-drill-${DRILL_VERSION}/conf/drill-env.sh" && \
    perl -pi -e "s/^(\s*)zk.connect:.*/\\1zk.connect: \"${ZOOKEEPER_HOST}\"/" "apache-drill-${DRILL_VERSION}/conf/drill-override.conf" && \
    :
    #yum install -y supervisor && \
    #yum clean all

EXPOSE 8047

#CMD /usr/bin/supervisord -n
CMD /apache-drill/bin/drill-embedded
