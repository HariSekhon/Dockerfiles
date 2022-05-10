#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-01-26 22:51:25 +0000 (Tue, 26 Jan 2016)
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback
#
#  https://www.linkedin.com/in/HariSekhon
#

# NOT USED

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# busybox's egrep and sed ERE are broken, don't recognize \. - doing something a bit more basic but it works
ip="$(ifconfig | grep -m1 'inet addr:' | sed 's/.*inet addr://;s/ .*$//')"

# none of this seems necessary with serf
args=""
if [ $# -eq 0 ] || [ "${1:-}" = "agent" ]; then
    args="-bind $ip -rpc-addr $ip:7373"
fi

# want arg splitting
# shellcheck disable=SC2086
exec /serf "$@" $args
