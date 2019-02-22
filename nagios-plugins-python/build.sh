#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2019-02-21 14:43:32 +0000 (Thu, 21 Feb 2019)
#
#  https://github.com/harisekhon/Dockerfiles
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

set -euxo pipefail

x=nagios-plugins

apt-get update

apt-get install -y git make

if ! [ -d "/github/$x" ]; then
    git clone "https://github.com/harisekhon/$x" "/github/$x"
    cd "/github/$x"
    git submodule update --init --recursive
fi

cd "/github/$x"

git pull

git submodule update --recursive

make python

apt-get autoremove -y

apt-get clean

# run tests after autoremove to check that no important packages we need get removed
pushd pylib
make deep-clean
popd

# leave git it's needed for Git-Python and check_git_branch_checkout.pl/py
# leave make, it's needed for quick updates
#apt-get remove -y make

apt-get autoremove -y

apt-get clean

bash-tools/check_docker_clean.sh

# basic test for missing dependencies again

find . -name '*.pl' -exec rm -v {} \;

tests/help.sh

rm -fr bash-tools lib
