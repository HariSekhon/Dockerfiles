#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-04-24 21:29:46 +0100 (Sun, 24 Apr 2016)
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

export SOLR_HOME="/solr"

# solr -e cloud fails if not called from $SOLR_HOME
cd "$SOLR_HOME"

# exits with 141 for pipefail breaking yes stdout
set +o pipefail
solr -e cloud -noprompt
if ls -d "$SOLR_HOME"-4* &>/dev/null; then
    tail -f /dev/null "$SOLR_HOME"/node*/logs/*
else
    tail -f /dev/null "$SOLR_HOME"/example/cloud/node*/logs/*
fi
