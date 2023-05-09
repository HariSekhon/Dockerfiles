#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2019-02-21 14:38:20 +0000 (Thu, 21 Feb 2019)
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

apt-get update

apt-get install -y git make

# just for check_puppet.rb, but it doesn't make sense to use that plugin in a container as it's a local style plugin
#apt-get install -y ruby

if ! [ -d "/github/$repo" ]; then
    git clone "https://github.com/harisekhon/$repo" "/github/$repo"
    cd "/github/$repo"
    git submodule update --init --recursive
fi

cd "/github/$repo"

git pull

git submodule update --init --recursive

make update zookeeper

make apt-packages-remove

apt-get autoremove -y

apt-get clean

# run tests after autoremove to check that no important packages we need get removed
make test deep-clean

# leave git it's needed for Git-Python and check_git_branch_checkout.pl/py
# leave make for easier updates
#apt-get remove -y make

apt-get autoremove -y

apt-get clean

bash-tools/checks/check_docker_clean.sh

# basic test for missing dependencies again
tests/help.sh
