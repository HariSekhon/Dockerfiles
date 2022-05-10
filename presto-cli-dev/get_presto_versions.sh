#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2017-09-15 12:58:47 +0200 (Fri, 15 Sep 2017)
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
#srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# parse all versions, return numerically newest first (as you may want to Control-C but have the latest ones built by the point rather than have to wait for all the old versions before getting the newest one
get_presto_versions(){
    curl -sS https://repo1.maven.org/maven2/com/facebook/presto/presto-server/ |
    grep -Eo '>[[:digit:]]+\.[[:digit:]]+/' |
    sed 's/[>/]//g ; s/\./ /' |
    sort -rnk1 -k 2 |
    sed 's/ /./'
}

get_presto_versions
