#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-09-23 09:16:45 +0200 (Fri, 23 Sep 2016)
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
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. "$srcdir/../bash-tools/utils.sh"

section "Dockerfiles PyTools Checks"

export PROJECT=Dockerfiles

# start time is run in here
. "$srcdir/../bash-tools/check_pytools.sh"

pushd "$srcdir/.."

dockerfiles_check_git_branches.py .
echo

git_check_branches_upstream.py --fix .
echo

popd

time_taken "$start_time"
section2 "PyTools validations SUCCEEDED"
echo
