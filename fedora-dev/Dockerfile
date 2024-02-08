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

#FROM harisekhon/fedora-scala:2.11-jdk8
# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM harisekhon/fedora-scala:latest

LABEL org.opencontainers.image.description="Fedora Dev Build" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/fedora-dev" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/fedora-dev" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

ENV GRADLE_HOME=/opt/gradle
ENV JYTHON_HOME=/opt/jython
ENV PATH $PATH:$GRADLE_HOME/bin:$JYTHON_HOME/bin

RUN bash -c ' \
    set -euxo pipefail && \
    yum install -y \
    curl \
    cyrus-sasl-devel \
    dstat \
    expat-devel \
    expect \
    ethtool \
    gcc \
    gcc-c++ \
    git \
    groovy \
    hostname \
    libev \
    libev-devel \
    make \
    maven \
    mysql-devel \
    net-tools \
    openssl-devel \
    perl \
    perl-CPAN \
    perl-App-cpanminus \
    perl-DBD-MySQL \
    perl-libwww-perl \
    python-devel \
    python-pip \
    python-setuptools \
    ruby \
    ruby-devel \
    snappy-devel \
    sysstat \
    tar \
    unzip \
    vim-enhanced \
    wget \
    which \
    yum-plugin-security \
    #yum-security \
    zip \
    jwhois && \
    curl -L https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo && \
    yum install -y --nogpgcheck sbt && \
    yum autoremove -y && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    # workaround for CentOS (found via strace) otherwise incorrectly states "Warning: You do not have write permission for Perl library directories." and local::lib hits use of uninitialized variables errors in base modules like even core File::Basename :-/
    mkdir -v /usr/local/share/perl5 /usr/local/lib64/perl5 \
    '

# Gradle doesn't have an RPM :-(
RUN bash -c ' \
    set -euxo pipefail && \
    wget https://raw.githubusercontent.com/HariSekhon/bash-tools/master/install/install_gradle.sh && \
    bash install_gradle.sh && \
    rm -f install_gradle.sh \
    '

# Jython
RUN bash -c ' \
    set -euxo pipefail && \
    wget https://raw.githubusercontent.com/HariSekhon/devops-python-tools/master/jython_install.sh && \
    wget https://raw.githubusercontent.com/HariSekhon/devops-python-tools/master/jython_autoinstall.exp && \
    bash jython_install.sh && \
    rm -f jython_install.sh jython_autoinstall.exp \
    '

CMD ["/bin/bash"]
