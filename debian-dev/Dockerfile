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
#  http://www.linkedin.com/in/harisekhon
#

FROM debian:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Debian Dev Build"

RUN apt-get update && \
    apt-get install -y build-essential \
                       git \
                       make \
                       maven \
                       python-dev \
                       python-setuptools \
                       python-pip \
                       ruby \
                       ruby-dev \
                       openjdk-7-jdk \
                       libexpat1-dev \
                       libssl-dev \
                       libsasl2-dev \
                       libmysqlclient-dev \
                       libdbd-mysql-perl \
                       libkrb5-dev \
                       libev4 \
                       libsnappy-dev \
                       vim \
                       wget && \
    # for sbt https repo
    apt-get install -y apt-transport-https && \
    echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823 && \
    apt-get update && \
    apt-get install -y sbt && \
    # for Maven 3
    #echo deb http://ppa.launchpad.net/natecarlson/maven3/ubuntu precise main >> /etc/apt/sources.list && \
    #apt-get update && \
    #apt-get install -y maven && \
    apt-get clean

CMD /bin/bash
