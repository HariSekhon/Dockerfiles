#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-12-15 13:03:17 +0000 (Thu, 15 Dec 2016)
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

cd "$srcdir/.."

echo "checking docker image calls match directory tree"
for x in *; do
    [ -d "$x" ] || continue
    [ "$x" = "bash-tools" ] && continue
    [ -f "$x/docker-compose.yml" ] || continue
    # exclude things not in Git yet
    git log -1 "$x" 2>/dev/null | grep -q '.*' || continue
    for compose_file in "$x/"*docker-compose*.yml; do
        # this allows us to skip things like rabbitmq-cluster
        if grep -q image "$compose_file"; then
            if ! grep -Eq "^[[:space:]]*image:[[:space:]]*harisekhon/$x(:\\$\\{VERSION:-latest\\}|:latest)?[[:space:]]*$" "$compose_file"; then
                echo "$x docker-compose.yml image mismatch!"
                exit 1
            fi
        fi
    done
done
echo "Docker-compose images matched expected names for directory tree"
