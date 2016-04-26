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
if ! [ -f /root/.ssh/known_hosts ]; then
    ssh-keyscan localhost | tee -a /root/.ssh/known_hosts
    ssh-keyscan 0.0.0.0 | tee -a /root/.ssh/known_hosts
fi
hostname=$(hostname -f)
grep -q "$hostname" /root/.ssh/known_hosts ||
    ssh-keyscan $hostname | tee -a /root/.ssh/known_hosts

#mkdir /hadoop/logs

sed -i "s/localhost/$hostname/" /hadoop/etc/hadoop/core-site.xml

/hadoop/sbin/start-dfs.sh
tail -f /hadoop/logs/*
/hadoop/sbin/stop-dfs.sh
