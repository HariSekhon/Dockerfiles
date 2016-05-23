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
set -x

srcdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export JAVA_HOME="${JAVA_HOME:-/usr}"

# solr -e cloud fails if not called from $SOLR_HOME
cd /solr

if [ $# -gt 0 ]; then
    exec $@
else
    # exits with 141 for pipefail breaking yes stdout
    set +o pipefail
    yes "" | solr -e cloud
    if ls -d /solr-4* &>/dev/null; then
        tail -f /solr/node*/logs/*
    else
        tail -f /solr/example/cloud/node*/logs/*
    fi
fi
