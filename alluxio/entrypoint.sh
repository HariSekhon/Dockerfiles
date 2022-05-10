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

if [ $# -gt 0 ]; then
    exec "$@"
else
    #if ! [ -f /root/.ssh/authorized_keys ]; then
    #    ssh-keygen -t rsa -b 1024 -f /root/.ssh/id_rsa -N ""
    #    cp -v /root/.ssh/{id_rsa.pub,authorized_keys}
    #    chmod -v 0400 /root/.ssh/authorized_keys
    #fi

    #if ! [ -f /etc/ssh/ssh_host_rsa_key ]; then
    #    /usr/sbin/sshd-keygen
        #ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
        #ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
        #ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
        #ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519
    #fi

    #if ! pgrep -x sshd &>/dev/null; then
    #    /usr/sbin/sshd
    #    sleep 1
    #fi
    #/alluxio/bin/alluxio-start.sh local
    #/alluxio/bin/alluxio-start.sh safe

    # fails first time
    /alluxio/bin/alluxio-start.sh master ||
        /alluxio/bin/alluxio-start.sh master

    # Worker now needs NoMount and master property to start
    grep -q '^[[:space:]]*alluxio.master.hostname' /alluxio/conf/alluxio-site.properties ||
        echo alluxio.master.hostname=localhost >> /alluxio/conf/alluxio-site.properties

    /alluxio/bin/alluxio-start.sh worker NoMount
    sleep 2
    cat /alluxio/logs/* || :
    echo "================="
    tail -f /dev/null /alluxio/logs/*
fi
