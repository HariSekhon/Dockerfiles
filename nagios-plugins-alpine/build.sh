#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2019-02-21 14:50:47 +0000 (Thu, 21 Feb 2019)
#
#  https://github.com/harisekhon/Dockerfiles
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

set -eu
[ -n "${DEBUG:-}" ] && set -x

mkdir -v /github

x=nagios-plugins

apk add --no-cache git make

if ! [ -d "/github/$x" ]; then
    git clone "https://github.com/harisekhon/$x" "/github/$x"
    cd "/github/$x"
    git submodule update --init --recursive
fi

cd "/github/$x"

make update zookeeper

make apk-packages-remove

make test deep-clean

# leave git it's needed for Git-Python and check_git_branch_checkout.pl/py
# leave make it's needed for updates later
#apk del make

bash-tools/check_docker_clean.sh

# basic test for missing dependencies again
tests/help.sh
