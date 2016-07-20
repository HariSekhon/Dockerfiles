#!/bin/bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-01-26 22:51:25 +0000 (Tue, 26 Jan 2016)
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

export SPARK_DAEMON_MEMORY="${SPARK_DAEMON_MEMORY:-128M}"

export SPARK_HOME="/spark"

mkdir -pv "$SPARK_HOME/logs"

if grep -q "^[[:space:]]*SPARK_DAEMON_MEMORY" "$SPARK_HOME/conf/spark-env.sh"; then
    sed -i "s/^[[:space:]]SPARK_DAEMON_MEMORY.*/SPARK_DAEMON_MEMORY=$SPARK_DAEMON_MEMORY/" "$SPARK_HOME/conf/spark-env.sh"
else
    echo "export SPARK_DAEMON_MEMORY=$SPARK_DAEMON_MEMORY" >> "$SPARK_HOME/conf/spark-env.sh" >> "$SPARK_HOME/conf/spark-env.sh"
fi

echo "Starting Master"
$SPARK_HOME/bin$SPARK_HOME-class org.apache.spark.deploy.master.Master &>$SPARK_HOME/logs/master.log &
sleep 2
echo

echo "Starting Worker"
$SPARK_HOME/bin$SPARK_HOME-class org.apache.spark.deploy.worker.Worker spark://$(hostname -f):7077 &>$SPARK_HOME/logs/worker.log &
sleep 2
echo

if [ -t 0 ]; then
    echo "Starting Spark Shell to connect to standalone daemons"
    # less than about 480m SQLContext fails to load and gets a bunch of NPEs
    $SPARK_HOME/bin/spark-shell --driver-memory 500m --master spark://$(hostname -f):7077
else
    echo -e "

Spark Shell will not be opened as this container is not running in interactive mode

To open Spark Shell in future start docker with the switches:

docker run -t -i ...
"
fi
echo -e "\n\nWill now read logs to keep container alive until killed...\n\n"
tail -f $SPARK_HOME/logs/* &
wait || :
