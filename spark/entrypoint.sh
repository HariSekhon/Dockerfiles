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

if ! [ -f /root/.ssh/authorized_keys ]; then
    ssh-keygen -t rsa -b 1024 -f /root/.ssh/id_rsa -N ""
    cp -v /root/.ssh/{id_rsa.pub,authorized_keys}
    chmod -v 0400 /root/.ssh/authorized_keys
fi

if ! [ -f /etc/ssh/ssh_host_rsa_key ]; then
    /usr/sbin/sshd-keygen
fi

if ! pgrep -x sshd &>/dev/null; then
    /usr/sbin/sshd
    sleep 1
fi

if [ $# -gt 0 ]; then
    exec $@
else
    /spark/sbin/start-all.sh local
    sleep 3
    cat /spark/logs/*
    echo "================="
    #tail -f /spark/logs/*
    /spark/bin/spark-shell --master spark://$(hostname -f):7077
fi
