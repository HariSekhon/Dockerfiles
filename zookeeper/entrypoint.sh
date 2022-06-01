#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-04-29 16:46:30 +0100 (Fri, 29 Apr 2016)
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

# 3.3 fails to start the first time with this dir
mkdir -p /tmp/zookeeper
# zookeeper.out will be written to $PWD
cd /tmp
zkServer.sh start
sleep 2
if [ -t 0 ]; then
    zkCli.sh
    echo -e '\n\nZooKeeper shell exited\n'
else
    echo "
Running non-interactively, will not open ZooKeeper shell

For ZooKeeper shell start this image with 'docker run -t -i' switches
"
fi
echo -e '\nWill tail log now to keep this container alive until killed...\n\n'
sleep 30
tail -f /dev/null zookeeper.out &
wait || :
