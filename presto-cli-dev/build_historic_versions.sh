#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2017-09-15 11:02:16 +0200 (Fri, 15 Sep 2017)
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$srcdir"

# shellcheck disable=SC1090
. "$srcdir/../bash-tools/lib/utils.sh"

section "Presto CLI - building Development Versions"

no_cache=""
if [ -n "${NOCACHE:-}" ]; then
    no_cache="--no-cache"
fi

if [ -n "$*" ]; then
    versions_to_build="$*"
else
    # do not build latest version by default, leave that to automated build
    # originally did ../presto-dev/get_presto_versions.sh but it's needed inside the Dockerfile too to determine the latest version so much exist in this local context anyway
    versions_to_build="$(./get_presto_versions.sh | tail -n +2)"
fi

count=0

for version in $versions_to_build; do
    if [ "$version" = "latest" ]; then
        version="$(./get_presto_versions.sh | head -n1)"
    fi
    ((count+=1))
    section2 "Building Presto CLI version $version"
    docker build -t "harisekhon/presto-cli-dev:$version" --build-arg PRESTO_DEVELOPMENT_VERSION="$version" $no_cache .
    [ -n "${NOPUSH:-}" ] || docker push "harisekhon/presto-cli-dev:$version"
    # do not fill up all your space keeping each version around!!
    # do not remove every version, leave the first latest one, this will allow layer re-use for packages between all versions as the dependent layers for the latest version will not be removed and can be re-used as cache for all subsequent version builds saving time and space
    if [ $count -gt 1 ]; then
        docker rmi "harisekhon/presto-cli-dev:$version"
    fi
    echo
done

echo
echo "Successfully built $count versions of Presto CLI"
