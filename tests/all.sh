#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-07-25 18:14:49 +0100 (Mon, 25 Jul 2016)
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "$srcdir/.."

# shellcheck disable=SC1091
. bash-tools/lib/utils.sh

section "Dockerfiles checks"

tests/pytools_checks.sh

# in Travis we only test master branch
# - don't want PyTools checks applying to all branches because
#   they already check out every branch to test alignment of version numbers before commit + push
#   doing CI against every branch would become a multiplier of all branches vs all branches
#
# XXX: doesn't work Travis fails to check out any branches
#if ! is_CI; then
#if ! is_travis; then
if false; then
    branches="$(
    git ls-remote |
    awk '/\/heads\//{print $2}' |
    sed 's,^refs/heads/,,' |
    sed '
    s/^\* // ;
    s/.*\/// ;
    s/^[[:space:]]*// ;
    s/[[:space:]]*$// ;
    s/.*[[:space:]]// ;
    s/)[[:space:]]*//
    ' |
    sort -u
    )"
    for branch in $branches; do
        tests/tests_per_branch.sh "$branch"
    done
else
    tests/tests_per_branch.sh
fi

tests/projects_without_docker-compose_yet.sh

tests/projects_without_README_yet.sh

tests/check_for_new_versions.sh
