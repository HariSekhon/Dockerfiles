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

FROM harisekhon/ubuntu-java:jdk8
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Ubuntu Dev Build"

ENV DEBIAN_FRONTEND noninteractive

ENV JAVA_HOME=/usr
ENV JYTHON_HOME=/opt/jython
ENV PATH $PATH:$JYTHON_HOME/bin

RUN bash -c ' \
    set -euxo pipefail && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
                       bind9-host \
                       build-essential \
                       cpanminus \
                       curl \
                       dnsutils \
                       dstat \
                       expect \
                       ethtool \
                       fping \
                       git \
                       golang \
                       gradle \
                       groovy \
                       libdbd-mysql-perl \
                       libev4 \
                       libexpat1-dev \
                       libkrb5-dev \
                       libmysqlclient-dev \
                       libsasl2-dev \
                       libsnappy-dev \
                       libssl-dev \
                       lsof \
                       make \
                       maven \
                       netcat \
                       nmap \
                       net-tools \
                       procps \
                       python-dev \
                       python-pip \
                       python-setuptools \
                       ruby \
                       ruby-dev \
                       socat \
                       scala \
                       sysstat \
                       strace \
                       tcpdump \
                       unzip \
                       vim \
                       wget \
                       zip && \
    # for sbt https repo
    apt-get install -y --no-install-recommends apt-transport-https gnupg2 && \
    echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823 && \
    apt-get update && \
    apt-get install -y --no-install-recommends sbt && \
    # for Maven 3
    #echo deb http://ppa.launchpad.net/natecarlson/maven3/ubuntu precise main >> /etc/apt/sources.list && \
    #apt-get update && \
    #apt-get install -y maven && \
    apt-get autoremove -y && \
    apt-get clean'

# Jython
RUN bash -c ' \
    set -euxo pipefail && \
    wget https://raw.githubusercontent.com/HariSekhon/devops-python-tools/master/jython_install.sh && \
    wget https://raw.githubusercontent.com/HariSekhon/devops-python-tools/master/jython_autoinstall.exp && \
    bash jython_install.sh && \
    rm -f jython_install.sh jython_autoinstall.exp'

CMD ["/bin/bash"]
