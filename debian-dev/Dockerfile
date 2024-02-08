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
FROM harisekhon/debian-java:jdk8

LABEL org.opencontainers.image.description="Debian Dev Build" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/debian-dev" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/debian-dev" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

ENV DEBIAN_FRONTEND noninteractive

ENV GRADLE_HOME=/opt/gradle
ENV JYTHON_HOME=/opt/jython
ENV PATH $PATH:$GRADLE_HOME/bin:$JYTHON_HOME/bin

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
        ethtool \
        expect \
        fping \
        git \
        golang \
        gradle \
        groovy \
        libdbd-mysql-perl \
        libev4 \
        libexpat1-dev \
        libkrb5-dev \
        libmariadbd-dev \
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
        # TODO: Scala 2.9, put newer scala on here
        scala \
        socat \
        strace \
        sysstat \
        tcpdump \
        unzip \
        vim \
        wget \
        zip \
        && \
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

# Gradle in Debian was old 1.5
#RUN bash -c 'set -euxo pipefail && curl https://raw.githubusercontent.com/HariSekhon/bash-tools/master/install/install_gradle.sh | sh'

# Jython
RUN set -eux && \
    wget https://raw.githubusercontent.com/HariSekhon/devops-python-tools/master/jython_install.sh && \
    wget https://raw.githubusercontent.com/HariSekhon/devops-python-tools/master/jython_autoinstall.exp && \
    bash jython_install.sh && \
    rm -fv jython_install.sh jython_autoinstall.exp

CMD ["/bin/bash"]
