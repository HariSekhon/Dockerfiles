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

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

export JAVA_HOME="${JAVA_HOME:-/usr}"

export SPARK_DAEMON_MEMORY="${SPARK_DAEMON_MEMORY:-128M}"

export SPARK_HOME="/spark"

mkdir -pv "$SPARK_HOME/logs"
echo

echo "reconfiguring memory to $SPARK_DAEMON_MEMORY"
if grep -q "^[[:space:]]*SPARK_DAEMON_MEMORY" "$SPARK_HOME/conf/spark-env.sh"; then
    sed -i "s/^[[:space:]]SPARK_DAEMON_MEMORY.*/SPARK_DAEMON_MEMORY=$SPARK_DAEMON_MEMORY/" "$SPARK_HOME/conf/spark-env.sh"
else
    echo "export SPARK_DAEMON_MEMORY=$SPARK_DAEMON_MEMORY" >> "$SPARK_HOME/conf/spark-env.sh" >> "$SPARK_HOME/conf/spark-env.sh"
fi
echo

spark_version="$(find / -maxdepth 1 -type d -name 'spark-*' | sed 's|/spark-||;s/-.*//')"

echo "Spark Version = $spark_version"
echo

ip_address="$(ifconfig | awk '/inet/{print $2;exit}' | sed 's/.*://')"
echo "IP Address = $ip_address"
echo

echo "Starting Master"
echo "$SPARK_HOME"/bin/spark-class org.apache.spark.deploy.master.Master
"$SPARK_HOME"/bin/spark-class org.apache.spark.deploy.master.Master &>/spark/logs/master.log &
echo
sleep 2

echo "Starting Worker"
# 1.3 worker only registers successfully if calling master by hostname
if [ "${spark_version:0:3}" = "1.3" ]; then
    echo "$SPARK_HOME/bin/spark-class org.apache.spark.deploy.worker.Worker spark://$(hostname -f):7077"
    "$SPARK_HOME/bin/spark-class org.apache.spark.deploy.worker.Worker spark://$(hostname -f):7077" &>/spark/logs/worker.log &
else
    echo "$SPARK_HOME"/bin/spark-class org.apache.spark.deploy.worker.Worker "spark://$ip_address:7077"
    "$SPARK_HOME"/bin/spark-class org.apache.spark.deploy.worker.Worker "spark://$ip_address:7077" &>/spark/logs/worker.log &
fi
echo
sleep 2

if [ -t 0 ]; then
    echo -e '\nStarting Spark Shell to connect to standalone daemons\n'
    # less than about 480m SQLContext fails to load and gets a bunch of NPEs
    "$SPARK_HOME/bin/spark-shell" --driver-memory 500m --master "spark://$(hostname -f):7077"
    echo -e '\n\nSpark Shell exited\n\n'
else
    echo -e "

Spark Shell will not be opened as this container is not running in interactive mode

To open Spark Shell in future start docker with the switches:

docker run -t -i ...
"
fi
echo -e '\n\nWill now read logs to keep container alive until killed...\n\n'
tail -f /dev/null "$SPARK_HOME"/logs/* &
wait || :
