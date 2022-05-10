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

cd "$SOLR_HOME"

# Solr 5+ insists on SOLR_HOME being set to /solr/server/solr dir containing solr.xml
set +o pipefail # in case solr version doesn't exist in older versions
if [ "$(solr version|cut -c 1)" -ge 5 ]; then
    export SOLR_HOME="$SOLR_HOME/server/solr"
    solr start -f
else
    cd "$SOLR_HOME/example"
    java -jar start.jar
fi
