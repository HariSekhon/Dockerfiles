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

FROM harisekhon/centos-jre7
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="CentOS Dev Build"

RUN yum install -y \
    git \
    make \
    gcc \
    gcc-c++ \
    git \
    maven \
    perl \
    perl-CPAN \
    perl-libwww-perl \
    python-devel \
    python-setuptools \
    python-pip \
    ruby \
    ruby-devel \
    openssl-devel \
    mysql-devel \
    net-tools \
    perl-DBD-MySQL \
    expat-devel \
    libev \
    libev-devel \
    snappy-devel \
    cyrus-sasl-devel \
    yum-security \
    yum-plugin-security \
    wget \
    tar \
    which \
    vim-enhanced \
    epel-release && \
    yum install -y jwhois && \
    curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo && \
    yum install -y --nogpgcheck sbt && \
    yum clean all && \
    # workaround for CentOS (found via strace) otherwise incorrectly states "Warning: You do not have write permission for Perl library directories." and local::lib hits use of uninitialized variables errors in base modules like even core File::Basename :-/
    mkdir -v /usr/local/share/perl5 /usr/local/lib64/perl5

CMD /bin/bash
