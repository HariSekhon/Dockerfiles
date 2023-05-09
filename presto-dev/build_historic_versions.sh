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

srcdir2="$srcdir"

# shellcheck disable=SC1090
. "$srcdir/../bash-tools/lib/utils.sh"

srcdir="$srcdir2"

section "Presto SQL - building Development Versions"

no_cache=""
if [ -n "${NOCACHE:-}" ]; then
    no_cache="--no-cache"
fi

if [ -n "$*" ]; then
    versions_to_build="$*"
else
    # do not build latest version by default, leave that to automated build
    versions_to_build="$(./get_presto_versions.sh | tail -n +2)"
fi

count=0

check_connector(){
    local min_version="$1"
    local name="$2"
    if [ "${version#*.}" -lt "${min_version#*.}" ]; then
        if [ -f "$srcdir/etc/catalog/$name.properties" ]; then
            if [ -n "${FORCE_FIX:-}" ]; then
                echo "FORCE_FIX set, removing unavailable catalog $name.properties to correctly build version $version:"
                rm -vf "$srcdir/etc/catalog/$name.properties"
            else
                echo "ERROR: $name connector not available in Presto version $version (< $min_version), make sure you've removed $srcdir/etc/catalog/$name.properties file before continuing to build the image otherwise it won't start up!"
                echo
                exit 1
            fi
        fi
    fi
}

check_config_property(){
    local min_version="$1"
    local name="$2"
    if [ "${version#*.}" -lt "${min_version#*.}" ]; then
        if grep "^[[:space:]]*${name}[[:space:]]*=" "$srcdir/etc/config.properties"; then
            if [ -n "${FORCE_FIX:-}" ]; then
                echo "FORCE_FIX set, commenting out unavailable property setting '$name' to correctly build version $version:"
                sed -i "s/^\\([[:space:]]*${name}[[:space:]]*=\\)/#\\1/" "$srcdir/etc/config.properties"
            else
                echo "ERROR: $name config property not available in Presto version $version (< $min_version), make sure to comment it out in $srcdir/etc/config.properties file before continuing to build the image other it won't start up!"
                exit 1
            fi
        fi
    fi
}

for version in $versions_to_build; do
    if [ "$version" = "latest" ]; then
        version="$(./get_presto_versions.sh | head -n1)"
    fi
    ((count+=1))
    section2 "Building Presto version $version"
    check_connector 0.168 memory
    check_connector 0.147 localfile
    check_connector 0.108 blackhole
    check_config_property 0.101 query.max-memory
    check_config_property 0.101 query.max-memory-per-node
    check_config_property 0.69  node-scheduler.include-coordinator
    # TODO: versions 0.68 and below do not start up properly due to requiring this and other now obsolete settings
    if [ "${version#*.}" -le 68 ]; then
        if ! grep presto-metastore.db.type "$srcdir/etc/config.properties"; then
            if [ -n "${FORCE_FIX:-}" ]; then
                echo "FORCE_FIX set, added necessary config presto-metastore.db.type=h2 to $srcdir/etc/config.properties"
                echo "presto-metastore.db.type=h2" >> "$srcdir/etc/config.properties"
            else
                echo "ERROR: required config presto-metastore.db.type is not set in $srcdir/etc/config.properties, image won't start up without this in this version!"
                exit 1
            fi
        fi
    fi
    # might not use cache due to Docker caching issue but can try using PULL=1
    [ -z "${PULL:-}" ] || docker pull "harisekhon/presto-dev:$version"
    docker build -t "harisekhon/presto-dev:$version" --build-arg PRESTO_VERSION="$version" $no_cache .
    [ -n "${NOPUSH:-}" ] || docker push "harisekhon/presto-dev:$version"
    # do not fill up all your space keeping each version around!!
    # do not remove every version, leave the first latest one, this will allow layer re-use for packages between all versions as the dependent layers for the latest version will not be removed and can be re-used as cache for all subsequent version builds saving time and space
    if [ $count -gt 1 ] && [ -z "${NODELETE:-}" ]; then
        docker rmi "harisekhon/presto-dev:$version"
    fi
    echo
done

echo
echo "Successfully built $count versions of Presto"
