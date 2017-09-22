#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2017-09-15 11:02:16 +0200 (Fri, 15 Sep 2017)
#
#  https://github.com/harisekhon/Dockerfiles
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. "$srcdir/../bash-tools/utils.sh"

section "Presto SQL - building Development Versions"

cd "$srcdir"

count=0
# do not build latest version, leave that to automated build
for version in $(./get_presto_versions.sh | tail -n +2); do
    let count+=1
    section2 "Building Presto version $version"
    docker build -t "harisekhon/presto-dev:$version" --build-arg PRESTO_DEVELOPMENT_VERSION="$version" .
    [ -n "${PUSH:-}" ] && docker push "harisekhon/presto-dev:$version"
    # do not fill up all your space keeping each version around!!
    # do not remove every version, leave the first latest one, this will allow layer re-use for packages between all versions as the dependent layers for the latest version will not be removed and can be re-used as cache for all subsequent version builds saving time and space
    if [ $count -gt 1 ]; then
        docker rmi "harisekhon/presto-dev:$version"
    fi
    echo
done

echo
echo "Successfully built $count versions of Presto"
