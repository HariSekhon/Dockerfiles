#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2018-10-07 13:53:06 +0100 (Sun, 07 Oct 2018)
#
#  https://github.com/harisekhon/Dockerfiles
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

# Check each directory for a check_for_new_version script in each directory and if found run it

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$srcdir/.."

. bash-tools/utils.sh

branch="${1:-}"

section "Checks for new upstream software versions"

start_time=$(date +%s)

for dir in *; do
    [ -d "$dir" ] || continue
    if [ -x "$dir/check_for_new_version" ]; then
        #echo -n "$dir/check_for_new_version: "
        "$dir/check_for_new_version"
    fi
done

secs=$(($(date +%s) - $start_time))

echo
section2 "Upstream checks completed in $secs secs"
