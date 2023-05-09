#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2019-02-22 22:37:02 +0000 (Fri, 22 Feb 2019)
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

if ! [ -d "/github/$repo" ]; then
    git clone "https://github.com/harisekhon/$repo" "/github/$repo"
    cd "/github/$repo"
    git submodule update --init --recursive
fi

cd "/github/$repo"

make perl zookeeper

make system-packages-remove

apt-get autoremove -y

apt-get clean

bash-tools/checks/check_docker_clean.sh

#EXT=pl make deep-clean test

# run tests after autoremove to check that no important packages we need get removed
pushd lib
make test deep-clean
popd


# run tests after autoremove to check that no important packages we need get removed
find . -iname "*.py" -exec rm {} \;

# basic test for missing dependencies again
tests/help.sh

rm -fr bash-tools pylib lib/bash-tools
