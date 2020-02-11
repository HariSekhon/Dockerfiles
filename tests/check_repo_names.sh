#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-02-18 00:02:54 +0000 (Thu, 18 Feb 2016)
#
#  https://github.com/harisekhon/Dockerfiles
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback
#
#  https://www.linkedin.com/in/harisekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$srcdir/.."

echo "checking repo names match directory tree"
for x in *; do
    [ -d "$x" ] || continue
    [ "$x" = "bash-tools" ] && continue
    [ "$x" = "pytools_checks" ] && continue
    [[ "$x" =~ devops-.*tools.* ]] && continue
    [ -f "$x/Makefile" ] || continue
    # exclude things not in Git yet
    #git log -1 "$x" 2>/dev/null | grep -q '.*' || continue
    # shellcheck disable=SC2001
    y="$(sed 's/\(.*nagios-plugins\)-\([[:alpha:]]*\)$/\1:\2/' <<< "$x")"
    grep -q -e "^REPO := harisekhon/$y" "$x/Makefile" ||
        { echo "$x Makefile REPO mismatch!"; exit 1; }
done
