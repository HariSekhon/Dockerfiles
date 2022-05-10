#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-12-16 09:33:19 +0000 (Fri, 16 Dec 2016)
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

cd "$srcdir/.."

# shellcheck disable=SC1091
. bash-tools/lib/utils.sh

section "Projects without README yet"

find . -maxdepth 1 -type d |
while read -r dir; do
    [ -f "$dir/README.md" ] ||
    basename "$dir"
done |
grep -Ev '^(alpine|centos|debian|ubuntu)-(dev|java|github)|pytools|tools|nagios-plugins|nagios-plugin-kafka|spark-apps|centos-scala|jython|tests|\..*$'
echo
echo
