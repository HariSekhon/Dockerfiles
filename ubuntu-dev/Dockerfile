#
#  Author: Hari Sekhon
#  Date: 2016-01-16 09:58:07 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM harisekhon/ubuntu-java:jdk8

LABEL org.opencontainers.image.description="Ubuntu Dev Build" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/ubuntu-dev" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/ubuntu-dev" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

ENV DEBIAN_FRONTEND noninteractive

ENV JAVA_HOME=/usr
ENV JYTHON_HOME=/opt/jython
ENV PATH $PATH:$JYTHON_HOME/bin

RUN bash -c ' \
    set -euxo pipefail && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
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
    apt-get install -y --no-install-recommends apt-transport-https gnupg2 && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" >> /etc/apt/sources.list.d/sbt.list && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian /" >> /etc/apt/sources.list.d/sbt_old.list && \
    curl -sSfL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import && \
    chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg && \
    apt-get update && \
    apt-get install -y sbt && \
    # for Maven 3
    #echo deb http://ppa.launchpad.net/natecarlson/maven3/ubuntu precise main >> /etc/apt/sources.list && \
    #apt-get update && \
    #apt-get install -y maven && \
    apt-get autoremove -y && \
    curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/bin/clean_caches.sh | sh \
    '

# Jython
RUN bash -c ' \
    set -euxo pipefail && \
    wget https://raw.githubusercontent.com/HariSekhon/devops-python-tools/master/jython_install.sh && \
    wget https://raw.githubusercontent.com/HariSekhon/devops-python-tools/master/jython_autoinstall.exp && \
    bash jython_install.sh && \
    rm -f jython_install.sh jython_autoinstall.exp'

CMD ["/bin/bash"]
