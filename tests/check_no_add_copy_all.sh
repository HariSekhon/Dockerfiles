#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-02-18 00:02:54 +0000 (Thu, 18 Feb 2016)
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback
#
#  https://www.linkedin.com/in/HariSekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$srcdir/.."

echo "checking no Dockerfiles do ADD/COPY ."
for directory in *; do
    [ -d "$directory" ] || continue
    [ -f "$directory/Dockerfile" ] || continue
    if grep '(ADD|COPY)[[:space:]]+\.' "$directory/Dockerfile"; then
        echo "$directory/Dockerfile contains ADD/COPY . - dangerous this is how you leak credentials!!"
        exit 1
    fi
done
