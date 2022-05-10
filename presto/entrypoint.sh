#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2017-09-13 14:47:23 +0200 (Wed, 13 Sep 2017)
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

PRESTO_HOME=/usr/lib/presto

if [ -t 0 ]; then
    # start as a daemon
    echo "Starting Presto engine as a daemon:
"
    su presto -c "$PRESTO_HOME/bin/launcher start"
    sleep 5
    echo "
waiting for 5 secs for Presto engine to initialize

Starting Presto shell:

See sample data from logs:

SHOW TABLES FROM localfile.logs;
"
    su presto -c "/usr/bin/presto --server localhost:8080" # --catalog hive --schema default
else
    echo "
Running non-interactively, will not open Presto SQL shell

For Presto SQL shell start this image with 'docker run -t -i' switches

Starting Presto engine as foreground process:
"
    # start in foreground
    su presto -c "$PRESTO_HOME/bin/launcher run"
fi
