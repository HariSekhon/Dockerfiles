#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2019-02-21 14:38:20 +0000 (Thu, 21 Feb 2019)
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

set -euxo pipefail
[ -n "${DEBUG:-}" ] && set -x

nagios_plugins="/github/nagios-plugins"

bash_tools="$nagios_plugins/bash-tools"

#cd "$nagios_plugins"

#git pull
#make update2

#cd bash-tools
#git pull origin master

cd /

"$bash_tools/setup/download_cassandra.sh"

yum clean all

rm -rf /var/cache/yum

"$bash_tools/checks/check_docker_clean.sh"
