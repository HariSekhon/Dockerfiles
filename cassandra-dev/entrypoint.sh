#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-04-29 16:49:24 +0100 (Fri, 29 Apr 2016)
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

if [ "$*" ]; then
    "$@"
else
    # recent versions 3.5+ refuse to run as root
    #cassandra
    su cassandra "$(type -P cassandra)"
    count=0
    while true; do
        logfile="/cassandra/logs/system.log"
        [ -f "/var/log/cassandra/system.log" ] &&
            logfile="/var/log/cassandra/system.log"
        grep 'Starting listening for CQL clients' "$logfile" && break
        ((count+=1))
        if [ $count -gt 20 ]; then
            echo
            echo
            echo "Didn't find CQL startup in cassandra system.log, trying CQL anyway"
            break
        fi
        echo -n .
        sleep 1
    done
    echo
    echo
    # bug workaround
    # https://issues.apache.org/jira/browse/CASSANDRA-11850
    export CQLSH_NO_BUNDLED=TRUE
    #cqlsh
    if [ -t 0 ]; then
        bind_address="$(netstat -lnt | awk '/:9042/{print $4}' | sed 's/:[[:digit:]]*.*//')"
        cqlsh="$(type -P cqlsh)"
        echo "su cassandra $cqlsh $bind_address"
        su cassandra "$cqlsh" "$bind_address"
        echo -e '\n\nCQL shell exited'
    else
        echo "
    Running non-interactively, will not open CQL shell

    For CQL shell start this image with 'docker run -t -i' switches

    "
    fi
    echo -e '\n\nWill tail logs now to keep this container alive until killed...\n\n'
    sleep 30
    tail -f /dev/null /cassandra/logs/* &
    wait || :
fi
