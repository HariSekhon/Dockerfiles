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

FROM harisekhon/alpine-java:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Alpine Dev Build"

#ENV GRADLE_HOME=/opt/gradle
ENV GROOVY_HOME=/opt/groovy
ENV JYTHON_HOME=/opt/jython
#ENV MAVEN_HOME=/opt/maven
ENV SBT_HOME=/opt/sbt

ENV PATH $PATH:$GRADLE_HOME/bin:$GROOVY_HOME/bin:$JYTHON_HOME/bin:$MAVEN_HOME/bin:$SBT_HOME/bin

RUN set -euxo pipefail && \
    mkdir -p /opt && \
    apk add --no-cache \
        acf-openssl \
        alpine-sdk \
        bash \
        bind-tools \
        curl \
        cyrus-sasl-dev \
        expat-dev \
        expect \
        ethtool \
        fping \
        gcc \
        git \
        go \
        gradle \
        grep \
        jwhois \
        libev \
        libevdev \
        libressl-dev \
        lsof \
        make \
        mariadb-dev \
        maven \
        netcat-openbsd \
        net-tools \
        nmap \
        nmap-ncat \
        perl \
        perl-dbd-mysql \
        perl-libwww \
        procps \
        py-mysqldb \
        py-pip \
        py-setuptools \
        python-dev \
        ruby \
        ruby-dev \
        snappy-dev \
        socat \
        strace \
        sysstat \
        tar \
        tcpdump \
        unzip \
        vim \
        wget \
        which \
        zip

# didn't have Gradle / Groovy / Maven / SBT packages ...

# Maven - has this now
#RUN set -euxo pipefail && \
#    curl https://raw.githubusercontent.com/HariSekhon/bash-tools/master/install_maven.sh | sh

# Gradle - has this now
#RUN set -euxo pipefail && curl https://raw.githubusercontent.com/HariSekhon/bash-tools/master/install_gradle.sh | sh

# SBT
RUN set -euxo pipefail && \
    cd /opt && \
    curl https://raw.githubusercontent.com/HariSekhon/bash-tools/master/install_sbt.sh | sh

# Groovy
RUN set -euxo pipefail && \
    curl https://raw.githubusercontent.com/HariSekhon/bash-tools/master/install_groovy.sh | sh

# Jython
RUN set -euxo pipefail && \
    wget https://raw.githubusercontent.com/HariSekhon/devops-python-tools/master/jython_install.sh && \
    wget https://raw.githubusercontent.com/HariSekhon/devops-python-tools/master/jython_autoinstall.exp && \
    sh jython_install.sh && \
    rm -f jython_install.sh jython_autoinstall.exp

CMD /bin/bash
