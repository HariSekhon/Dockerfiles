#
#  Author: Hari Sekhon
#  Date: 2016-01-16 09:58:07 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles/alpine-dev
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM alpine:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Alpine Dev Build"

ENV GRADLE_HOME=/opt/gradle
ENV GROOVY_HOME=/opt/groovy
ENV JYTHON_HOME=/opt/jython
ENV MAVEN_HOME=/opt/maven
ENV SBT_HOME=/opt/sbt

ENV PATH $PATH:$GRADLE_HOME/bin:$GROOVY_HOME/bin:$JYTHON_HOME/bin:$MAVEN_HOME/bin:$SBT_HOME/bin

RUN \
    mkdir -p /opt && \
    apk add --no-cache \
    bash \
    curl \
    cyrus-sasl-dev \
    expat-dev \
    expect \
    ethtool \
    gcc \
    git \
    jwhois \
    libev \
    libevdev \
    make \
    mariadb-dev \
    net-tools \
    openjdk8 \
    openssl-dev \
    perl \
    perl-dbd-mysql \
    perl-libwww \
    py-mysqldb \
    py-pip \
    py-setuptools \
    python-dev \
    ruby \
    ruby-dev \
    snappy-dev \
    sysstat \
    tar \
    unzip \
    vim \
    wget \
    which \
    zip

# doesn't have Gradle / Groovy / Maven / SBT packages ...

# Gradle
RUN \
    wget https://raw.githubusercontent.com/HariSekhon/bash-tools/master/install_gradle.sh && \
    sh install_gradle.sh && \
    rm -f install_gradle.sh

# Groovy
RUN \
    wget https://raw.githubusercontent.com/HariSekhon/bash-tools/master/install_groovy.sh && \
    sh install_groovy.sh && \
    rm -f install_groovy.sh

# Jython
RUN \
    wget https://raw.githubusercontent.com/HariSekhon/pytools/master/jython_install.sh && \
    wget https://raw.githubusercontent.com/HariSekhon/pytools/master/jython_autoinstall.exp && \
    sh jython_install.sh && \
    rm -f jython_install.sh jython_autoinstall.exp

# Maven
RUN \
    wget https://raw.githubusercontent.com/HariSekhon/bash-tools/master/install_maven.sh && \
    sh install_maven.sh && \
    rm -f install_maven.sh

# SBT
RUN \
    cd /opt && \
    wget https://raw.githubusercontent.com/HariSekhon/bash-tools/master/install_sbt.sh && \
    sh install_sbt.sh && \
    rm -f install_sbt.sh

COPY profile.d/java.sh   /etc/profile.d/

CMD /bin/bash
