#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-04-24 21:29:46 +0100 (Sun, 24 Apr 2016)
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

srcdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export JAVA_HOME="${JAVA_HOME:-/usr}"

# shell breaks and doesn't run zookeeper without this
mkdir /hbase/logs

# tries to run zookeepers.sh distributed via SSH, run zookeeper manually instead now
#RUN sed -i 's/# export HBASE_MANAGES_ZK=true/export HBASE_MANAGES_ZK=true/' /hbase/conf/hbase-env.sh
/hbase/bin/hbase zookeeper &>/hbase/logs/zookeeper.log &
/hbase/bin/start-hbase.sh
/hbase/bin/hbase-daemon.sh start rest
/hbase/bin/hbase-daemon.sh start thrift
#/hbase/bin/hbase-daemon.sh start thrift2
/hbase/bin/hbase shell
echo -e "\n\nAutomatic shutdown upon leaving HBase shell is now avoided by default to avoid confusion for people not running this image in non-interactive mode (which immediately closes the shell via the implicit EOF)

for details see https://github.com/harisekhon/Dockerfiles/issues/2\n\n"
read -p "Press 'Y' and enter if you want to shut down HBase, otherwise will leave it running: " answer
if [ "$answer" = "Y" ]; then
    /hbase/bin/stop-hbase.sh
    pkill -f org.apache.hadoop.hbase.zookeeper
    sleep 1
else
    tail -f /hbase/logs/*
fi
