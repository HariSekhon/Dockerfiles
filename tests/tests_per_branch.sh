#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2017-09-13 15:56:33 +0200 (Wed, 13 Sep 2017)
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# Tests that can be applied to each branch

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$srcdir/.."

# shellcheck disable=SC1091
. bash-tools/lib/utils.sh

branch="${1:-}"

hr2
echo "Test Branch $branch"
hr2

original_branch="$(git branch | awk '/\*/ {print $2}')"

if [ -n "$branch" ]; then
    echo "Checking out branch $branch"
    git remote update
    git fetch
    git checkout "$branch" # "origin/$branch"
fi

echo

tests/check_repo_names.sh

tests/check_no_add_copy_all.sh

tests/check_docker-compose_images.sh

tests/check_ports_exposed.sh

# is run in CI from pytools_checks.sh
#tests/devops-python-tools_checks_per_branch.sh

echo "Checking post build hook scripts separately as they're not inferred by .sh extension"
bash-tools/checks/check_bash_syntax.sh ./*/hooks/post_build
echo
echo

bash-tools/checks/check_all.sh

echo
if [ -n "$branch" ]; then
    hr2
    echo "Restoring branch $original_branch"
    git checkout "$original_branch"
    hr2
fi
echo
echo
