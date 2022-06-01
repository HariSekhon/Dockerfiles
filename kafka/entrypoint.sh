#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-07-14 16:35:56 +0100 (Thu, 14 Jul 2016)
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

ADVERTISED_HOSTNAME="${ADVERTISED_HOSTNAME:-127.0.0.1}"

zookeeper-server-start.sh /kafka/config/zookeeper.properties &

echo "*** waiting for 10 secs to give ZooKeeper time to start up"

sleep 10

echo "# ============================================================================ #"
echo "                         S t a r t i n g   K a f k a"
echo "# ============================================================================ #"

perl -pi.orig -e "s/\\s*#?\\s*advertised.host.name.*/advertised.host.name=${ADVERTISED_HOSTNAME}/" "/kafka/config/server.properties"

kafka-server-start.sh /kafka/config/server.properties
