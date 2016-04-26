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

#FROM harisekhon/centos-jre7
# > 100MB smaller than centos
FROM harisekhon/debian-jre7
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG ALLUXIO_VERSION=1.0.1

ENV PATH $PATH:/alluxio/bin

LABEL Description="Alluxio from BDAS" \
      "Alluxio Version"="$ALLUXIO_VERSION"

# use dev build it's quicker and cached
#RUN yum install -y java-1.7.0-openjdk && yum clean all

#COPY alluxio-$ALLUXIO_VERSION /alluxio

#RUN yum install -y sudo openssh-server && yum clean all
RUN apt-get update && \
    apt-get install -y sudo openssh-server wget tar && \
    wget -O "alluxio-${ALLUXIO_VERSION}-bin.tar.gz" "http://alluxio.org/downloads/files/${ALLUXIO_VERSION}/alluxio-${ALLUXIO_VERSION}-bin.tar.gz" && \
    tar zxvf "alluxio-${ALLUXIO_VERSION}-bin.tar.gz" && \
    rm -fv "alluxio-${ALLUXIO_VERSIO}-bin.tar.gz" && \
    ln -sv "alluxio-${ALLUXIO_VERSION}" alluxio && \
    cp -v /alluxio/conf/alluxio-env.sh.template /alluxio/conf/alluxio-env.sh && \
    mkdir /var/run/sshd && chmod 0755 /var/run/sshd && \
    alluxio format && \
    apt-get remove -y wget && \
    apt-get autoremove -y && \
    apt-get clean

COPY entrypoint.sh /

EXPOSE 19999 30000

ENTRYPOINT ["/entrypoint.sh"]
#CMD /usr/sbin/sshd; sleep 1; alluxio-start.sh local; sleep 2; cat /alluxio/logs/*; tail -f /alluxio/logs/*
