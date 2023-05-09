#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2019-02-21 14:57:26 +0000 (Thu, 21 Feb 2019)
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

set -euxo pipefail
[ -n "${DEBUG:-}" ] && set -x

mkdir -pv /github

repo=nagios-plugins

yum install -y git make

# just for check_puppet.rb, but it doesn't make sense to use that plugin in a container as it's a local style plugin
#yum install -y ruby

if ! [ -d "/github/$repo" ]; then
    git clone "https://github.com/harisekhon/$repo" "/github/$repo"
    cd "/github/$repo"
    git submodule update --init --recursive
fi

cd "/github/$repo"

# The first compile fails with an upstream perl cpan error, second compile works
#make build || : ; \
#make build zookeeper

make update zookeeper

#make yum-packages-remove

# run tests after autoremove to check that no important packages we need get removed
make test deep-clean

# leave git it's needed for Git-Python and check_git_branch_checkout.pl/py
# leave make for faster updates
#yum remove -y make

# these will get autoremoved as dependencies of make
# setting these as yum install manually doesn't protect them from autoremove by this point, must re-install afterwards :-/
#yum install -y perl-HTTP-Parser perl-Digest

yum autoremove -y

# the above yum install should work in theory to mark these packages as manually installed but in practice doesn't :-/
#yum install -y perl-HTTP-Parser perl-Digest

# try autoremove again and then test to ensure these packages are safe by this point
#yum autoremove -y

# for some reason openssl ends up being missing here when it doesn't show up on manual autoremove
#yum install -y openssl jwhois

yum clean all

rm -rf /var/cache/yum

bash-tools/checks/check_docker_clean.sh

# basic test for missing dependencies again
tests/help.sh
