#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2018-10-07 13:53:06 +0100 (Sun, 07 Oct 2018)
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# Check each directory for a check_for_new_version script in each directory and if found run it

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir2="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$srcdir2/.."

# shellcheck disable=SC1091
. bash-tools/lib/utils.sh

srcdir="$srcdir2"

section "Checks for new upstream software versions"

start_time=$(date +%s)

check_for_new_version(){
    local name="$1"
    versions="$("$name/get_versions" || :)"

    if [ -z "$versions" ]; then
        echo "WARNING: could not determine upstream versions of $name"
    fi

    latest_version="$(
        sort -k1n -k2n -k3n <<< "${versions//./ }" |
        sed 's/ /./g' |
        tail -n 1 || :
    )"

    dockerfile_version="$(
        grep -Ei "^ARG .*${name%-*}.*_VERSION=" "$srcdir/../$name/Dockerfile" |
        awk -F= '{print $2}' || :
    )"

    if [ -z "$dockerfile_version" ]; then
        echo "WARNING: $name: failed to determine Dockerfile version"
    fi

    if [ "$dockerfile_version" = "$latest_version" ]; then
        echo "$name up-to-date Dockerfile version / latest upstream version = $dockerfile_version / $latest_version"
    else
        echo "WARNING: $name: newer version available, current in Dockerfile = $dockerfile_version, latest upstream version = $latest_version"
    fi
}

if [ -n "$*" ]; then
    echo "Running check for: $*"
    echo
    for name in "$@"; do
        check_for_new_version "$name"
    done
else
    echo "Finding and running check for all builds with get_versions"
    echo
    for dir in *; do
        [ -d "$dir" ] || continue
        if [ -x "$dir/get_versions" ]; then
            #echo -n "$dir/check_for_new_version $dir: "
            check_for_new_version "$dir"
        fi
    done
fi

secs=$(($(date +%s) - start_time))

echo
section2 "Upstream checks completed in $secs secs"
