#!/usr/bin/env bash
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

if [ $# -gt 0 ]; then
    exec "$@"
else
    # This only runs a master
    #/usr/bin/mesos-local
    echo "Starting Mesos Master:"
    mesos master --work_dir=/var/lib/mesos --log_dir=/tmp/mesos-master-logs --cluster=myCluster &
    sleep 2
    echo "Starting Mesos Worker:"
    set +eo pipefail
    ip_address="$(ifconfig | awk '/inet addr/{print $2; exit}' | sed 's/.*://')"
    if [ -z "$ip_address" ]; then
        echo "FAILED to find IP Address, cannot launch worker as will get expected master mismatch"
        exit 1
    fi
    set -eo pipefail
    mesos slave --master="$ip_address:5050" --log_dir=/tmp/mesos-slave-logs --no-systemd_enable_support --launcher=posix &
    sleep 1
    echo "================="
    cat /tmp/mesos-master-logs/* || :
    cat /tmp/mesos-slave-logs/*  || :
    tail -f /dev/null /tmp/mesos-master-logs/* /tmp/mesos-slave-logs/*
fi
