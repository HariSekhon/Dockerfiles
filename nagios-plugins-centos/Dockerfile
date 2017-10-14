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

FROM centos:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Advanced Nagios Plugins Collection (CentOS build)"

ENV PATH $PATH:/github/nagios-plugins

RUN mkdir -v /github

WORKDIR /github

# drops in to /bin/sh pushd not available, could bash -c but explicit paths are good enough
RUN set -euxo pipefail && \
    x=nagios-plugins && \
    yum install -y git make && \
    # just for check_puppet.rb, but it doesn't make sense to use that plugin in a container as it's a local style plugin
    #yum install -y ruby && \
    git clone https://github.com/harisekhon/$x /github/$x && \
    cd /github/$x && \
    # The first compile fails with an upstream perl cpan error, second compile works
    make build || : ; \
    make build zookeeper && \
    make yum-packages-remove && \
    # run tests after autoremove to check that no important packages we need get removed
    make test deep-clean && \
    # leave git it's needed for Git-Python and check_git_branch_checkout.pl/py
    yum remove -y make && \
    # these will get autoremoved as dependencies of make
    # setting these as yum install manually doesn't protect them from autoremove by this point, must re-install afterwards :-/
    yum install -y perl-HTTP-Parser perl-Digest && \
    yum autoremove -y && \
    # the above yum install should work in theory to mark these packages as manually installed but in practice doesn't :-/
    yum install -y perl-HTTP-Parser perl-Digest && \
    # try autoremove again and then test to ensure these packages are safe by this point
    yum autoremove -y && \
    # for some reason openssl ends up being missing here when it doesn't show up on manual autoremove
    yum install -y openssl jwhois && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    bash-tools/check_docker_clean.sh && \
    # basic test for missing dependencies again
    tests/help.sh

WORKDIR /github/nagios-plugins

# trying to do -exec basename {} \; results in only the jython files being printed
CMD /bin/bash -c "find /github/nagios-plugins -maxdepth 2 -type f -iname '[A-Za-z]*.pl' -o -iname '[A-Za-z]*.py' | grep -iv makefile | xargs -n1 basename | sort"
