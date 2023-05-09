#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-09-23 09:16:45 +0200 (Fri, 23 Sep 2016)
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1090
. "$srcdir/../bash-tools/lib/utils.sh"

section "Dockerfiles PyTools Checks"

export PROJECT=Dockerfiles

# start time is run in here
# shellcheck disable=SC1090
. "$srcdir/../bash-tools/checks/check_pytools.sh"

# set in check_pytools.sh
# shellcheck disable=SC2154
if [ -n "${skip_checks:-}" ]; then
    exit 0
fi

pushd "$srcdir/.."

dockerfiles_check_git_branches.py .
echo

git_check_branches_upstream.py --fix .
echo

popd

# start_time is defined in check_pytools.sh imported above
# shellcheck disable=SC2154
time_taken "$start_time"
section2 "PyTools validations SUCCEEDED"
echo
