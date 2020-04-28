#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2020-04-28 17:46:31 +0100 (Tue, 28 Apr 2020)
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

nagios_plugins="/github/nagios-plugins"

if [ -d "$HOME/github/nagios-plugins" ]; then
    nagios_plugins="$HOME/github/nagios-plugins"
fi

submodules="$(cd "$nagios_plugins"; git submodule status | awk '{print $2}')"

# shellcheck disable=SC2046
# trying to do -exec basename {} \; results in only the jython files being printed
find "$nagios_plugins" \
    -maxdepth 2 \
    -type f \
    -iname '[A-Za-z]*.sh' -o \
    -iname '[A-Za-z]*.pl' -o \
    -iname '[A-Za-z]*.py' |
grep -iv -e makefile -e lib_ -e /tests/ -e /setup/ \
         $(for submodule in $submodules; do echo -n "-e $submodule "; done) |
xargs -n1 basename |
sort
