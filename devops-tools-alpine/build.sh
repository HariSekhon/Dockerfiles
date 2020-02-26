#!/usr/bin/env bash
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

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# building off pytools so don't need to include that
export REPOS="bash-tools perl-tools"

curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/git_pull_make_repos.sh | bash
curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/docker_clean.sh | sh
