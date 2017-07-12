#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-04-24 21:29:46 +0100 (Sun, 24 Apr 2016)
#
#  https://github.com/harisekhon/Dockerfiles/solrcloud
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

export SOLR_HOME="/solr"

export SOLR_USER="solr"
WHOAMI="$(whoami)"
if [ -n "$WHOAMI" -a "$WHOAMI" != "root" ]; then
    export SOLR_USER="$WHOAMI"
fi

set +o pipefail

if [ $# -gt 0 ]; then
    exec $@
else
    su - "$SOLR_USER" <<-EOF

    # preserve path from root Dockerfile which has location of $SOLR_HOME/bin
    export PATH=$PATH

    # solr -e cloud fails if not called from $SOLR_HOME
    cd "$SOLR_HOME"

    if [ $# -gt 0 ]; then
        exec $@
    else
        # exits with 141 for pipefail breaking yes stdout
        set +o pipefail
        solr -e cloud -noprompt
        if ls -d "$SOLR_HOME"-4* &>/dev/null; then
            tail -f "$SOLR_HOME/"node*/logs/*
        else
            tail -f "$SOLR_HOME/example/cloud/"node*/logs/*
        fi
    fi
EOF
fi
