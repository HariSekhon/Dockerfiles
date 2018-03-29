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

echo "================================================================================"
echo "                      HBase Development Docker Container"
echo "================================================================================"
echo
# shell breaks and doesn't run zookeeper without this
mkdir -pv /hbase/logs

# kill any pre-existing rest or thrift instances before starting new ones
pgrep -f proc_rest && pkill -9 -f proc_rest
pgrep -f proc_thrift && pkill -9 -f proc_thrift

# tries to run zookeepers.sh distributed via SSH, run zookeeper manually instead now
#RUN sed -i 's/# export HBASE_MANAGES_ZK=true/export HBASE_MANAGES_ZK=true/' /hbase/conf/hbase-env.sh
echo
echo "Starting local Zookeeper"
/hbase/bin/hbase zookeeper &>/hbase/logs/zookeeper.log &
echo

echo "Starting HBase"
/hbase/bin/start-hbase.sh
echo

# HBase versions < 1.0 fail to start RegionServer without SSH being installed
if [ "$(echo /hbase-* | sed 's,/hbase-,,' | cut -c 1)" = 0 ]; then
    echo "Starting local RegionServer"
    /hbase/bin/local-regionservers.sh start 1
    echo
fi

echo "Starting HBase Stargate Rest API server"
/hbase/bin/hbase-daemon.sh start rest
echo

echo "Starting HBase Thrift API server"
/hbase/bin/hbase-daemon.sh start thrift
#/hbase/bin/hbase-daemon.sh start thrift2
echo

trap_func(){
    echo -e "\n\nShutting down HBase:"
    /hbase/bin/hbase-daemon.sh stop rest || :
    /hbase/bin/hbase-daemon.sh stop thrift || :
    /hbase/bin/local-regionservers.sh stop 1 || :
    # let's not confuse users with superficial errors in the Apache HBase scripts
    /hbase/bin/stop-hbase.sh | grep -v -e "ssh: command not found" -e "kill: you need to specify whom to kill" -e "kill: can't kill pid .*: No such process"
    sleep 2
    ps -ef | grep org.apache.hadoop.hbase | grep -v -i org.apache.hadoop.hbase.zookeeper | awk '{print $1}' | xargs kill 2>/dev/null || :
    sleep 3
    pkill -f org.apache.hadoop.hbase.zookeeper 2>/dev/null || :
    sleep 2
}
trap trap_func INT QUIT TRAP ABRT TERM EXIT

if [ -t 0 ]; then
    echo "
Example Usage:

create 'table1', 'columnfamily1'

put 'table1', 'row1', 'columnfamily1:column1', 'value1'

get 'table1', 'row1'


Now starting HBase Shell...
"
    /hbase/bin/hbase shell
else
    echo "
Running non-interactively, will not open HBase shell

For HBase shell start this image with 'docker run -t -i' switches
"
    tail -f /dev/null /hbase/logs/* &
    # this shuts down from Control-C but exits prematurely, even when +euo pipefail and doesn't shut down HBase
    # so I rely on the sig trap handler above
    wait || :
fi
# this doesn't Control-C , gets stuck
#tail -f /hbase/logs/*
