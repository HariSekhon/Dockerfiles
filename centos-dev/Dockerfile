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

FROM harisekhon/centos-scala:2.11-jdk8
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="CentOS Dev Build"

ENV GRADLE_HOME=/opt/gradle
ENV JYTHON_HOME=/opt/jython
ENV PATH $PATH:$GRADLE_HOME/bin:$JYTHON_HOME/bin

# behaviour has changed in RHEL 8 - dnf doesn't install any packages if any of them can't be found
RUN bash -c ' \
    set -euxo pipefail && \
    for x in \
    bind-utils \
    curl \
    cyrus-sasl-devel \
    dstat \
    expat-devel \
    expect \
    ethtool \
    fping \
    gcc \
    gcc-c++ \
    git \
    groovy \
    hostname \
    httping \
    libev \
    libev-devel \
    lsof \
    make \
    maven \
    mysql-devel \
    nc \
    net-tools \
    nmap \
    nmap-ncat \
    openssl-devel \
    perl \
    perl-CPAN \
    #perl-App-cpanminus \
    perl-DBD-MySQL \
    perl-libwww-perl \
    procps \
    python \
    python-devel \
    python-pip \
    python-setuptools \
    python2 \
    python2-devel \
    python2-pip \
    python2-setuptools \
    python3 \
    python3-devel \
    python3-pip \
    python3-setuptools \
    ruby \
    ruby-devel \
    snappy-devel \
    socat \
    strace \
    sysstat \
    tar \
    tcpdump \
    unzip \
    vim-enhanced \
    wget \
    which \
    yum-plugin-security \
    yum-security \
    zip \
    epel-release \
    jwhois; do \
        rpm -q "$x" >/dev/null || yum install -y "$x" || :; \
    done; \
    curl -L https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo && \
    yum install -y --nogpgcheck sbt && \
    yum autoremove -y && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    # workaround for CentOS (found via strace) otherwise incorrectly states "Warning: You do not have write permission for Perl library directories." and local::lib hits use of uninitialized variables errors in base modules like even core File::Basename :-/
    mkdir -v /usr/local/share/perl5 /usr/local/lib64/perl5 \
    '

# Gradle doesn't have an RPM :-(
RUN set -eux && \
    wget https://raw.githubusercontent.com/HariSekhon/bash-tools/master/setup/install_gradle.sh && \
    bash install_gradle.sh && \
    rm -f install_gradle.sh

# Jython
RUN set -eux && \
    wget https://raw.githubusercontent.com/HariSekhon/devops-python-tools/master/jython_install.sh && \
    wget https://raw.githubusercontent.com/HariSekhon/devops-python-tools/master/jython_autoinstall.exp && \
    bash jython_install.sh && \
    rm -f jython_install.sh jython_autoinstall.exp

CMD ["/bin/bash"]
