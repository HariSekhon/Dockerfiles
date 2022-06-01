#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-04-24 21:29:46 +0100 (Sun, 24 Apr 2016)
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
#srcdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export JAVA_HOME="${JAVA_HOME:-/usr}"
export DRILL_HEAP="${DRILL_HEAP:-900M}"
export ZOOKEEPER_HOST="${ZOOKEEPER_HOST:-zookeeper}"

# for older versions
sed -i -e "s/-Xms1G/-Xms\$DRILL_MAX_HEAP/" apache-drill/conf/drill-env.sh
sed -i -e "s/^DRILL_MAX_HEAP=.*/DRILL_MAX_HEAP=\"${DRILL_HEAP}\"/" apache-drill/conf/drill-env.sh

sed -i -e "s/^DRILL_HEAP=.*/DRILL_HEAP=\"${DRILL_HEAP}\"/" apache-drill/conf/drill-env.sh
sed -i -e "s/^\\([[:space:]]*\\)zk.connect:.*/\\1zk.connect: \"${ZOOKEEPER_HOST}\"/" apache-drill/conf/drill-override.conf

if [ -t 0 ]; then
    # Embedded only
    # only works 1.0+
    #drill-embedded
    # backwards compatible for 0.x
    sqlline -u jdbc:drill:zk=local
else
    echo "
Running non-interactively, will not open Apache Drill SQL shell

For Apache Drill shell start this image with 'docker run -t -i' switches

Otherwise you will need to have a separate ZooKeeper container linked (one is available from harisekhon/zookeeper) and specify:

docker run -e ZOOKEEPER_HOST=<host>:2181 supervisord -n
"
fi
