#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2020-03-18 15:37:05 +0000 (Wed, 18 Mar 2020)
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

if [ -z "${APPVEYOR_TOKEN:-}" ]; then
    echo "\$APPVEYOR_TOKEN not found in environment"
    exit 1
fi

# leading whitespace break PowerShell commands
pwsh <<EOF
Import-Module AppVeyorBYOC
Connect-AppVeyorToComputer -AppVeyorUrl https://ci.appveyor.com -ApiToken $APPVEYOR_TOKEN
EOF
