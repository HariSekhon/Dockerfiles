#
#  Author: Hari Sekhon
#  Date: 2016-01-16 09:58:07 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles/centos-dev
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

RUN yum update -y && \
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
    yum-security \
    zip \
    epel-release && \
    yum install -y jwhois && \
    curl -L https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo && \
    yum install -y --nogpgcheck sbt && \
    yum autoremove -y && \
    yum clean all && \
    # workaround for CentOS (found via strace) otherwise incorrectly states "Warning: You do not have write permission for Perl library directories." and local::lib hits use of uninitialized variables errors in base modules like even core File::Basename :-/
    mkdir -v /usr/local/share/perl5 /usr/local/lib64/perl5

# Gradle doesn't have an RPM :-(
RUN wget https://raw.githubusercontent.com/HariSekhon/bash-tools/master/install_gradle.sh && \
    sh install_gradle.sh && \
    rm -f install_gradle.sh

# Jython
RUN wget https://raw.githubusercontent.com/HariSekhon/pytools/master/jython_install.sh && \
    wget https://raw.githubusercontent.com/HariSekhon/pytools/master/jython_autoinstall.exp && \
    sh jython_install.sh && \
    rm -f jython_install.sh jython_autoinstall.exp

CMD /bin/bash
