#!/bin/sh
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2019-03-16 14:44:58 +0000 (Sat, 16 Mar 2019)
#
#  https://github.com/harisekhon/Dockerfiles
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

set -eu #o pipefail
[ -n "${DEBUG:-}" ] && set -x

# doesn't work because it executes from within docker container where Makefile isn't available
#srcdir="$(dirname "$0")"
#repo="$(sed -n '/REPO/ s,.*/,,; s/:.*//; /tools/ p' Makefile)"

repo="$(env | grep ^PATH= | sed 's/.*github\///; s/:.*//')"

github="/github"

mkdir -pv "$github"

cd "$github"

wget -O- "https://raw.githubusercontent.com/HariSekhon/$repo/master/setup/bootstrap.sh" | sh

cd "$github/$repo"

make test

curl -sS "https://raw.githubusercontent.com/HariSekhon/bash-tools/master/docker_clean.sh" | sh
