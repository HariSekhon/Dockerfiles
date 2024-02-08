#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2019-03-17 11:16:17 +0000 (Sun, 17 Mar 2019)
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

mkdir -pv /github

cd /github

curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/install/install_sbt.sh | bash

if [ -n "$*" ]; then
    export REPOS="$*"
else
    export REPOS="bash-tools lib pylib perl-tools pytools" # spotify-tools
fi
curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/git/git_pull_make_repos.sh | bash

# downgrading certifi package is a workaround so that dockerhub_show_tags.py will work with SSL
#pip uninstall -y certifi && pip install certifi==2015.04.28

# could 'make deep-clean' to remove the wrappers and local build libs but it's a trade off between being able to develop quicker by not having to redownload them to recompile
# instead build each project with a different build tool and don't deep-clean so we have them cached for faster development in docker
export REPOS="lib-java" BUILD="gradle"
curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/git/git_pull_make_repos.sh | bash

export REPOS="nagios-plugin-kafka" BUILD="mvn"
curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/git/git_pull_make_repos.sh | bash

#export REPOS="spark-apps" BUILD="sbt"
#curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/git/git_pull_make_repos.sh | bash

# inherited instead now
#export REPOS="nagios-plugins" OPTS="zookeeper" NO_TEST=1
#curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/git/git_pull_make_repos.sh | bash

curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/bin/clean_caches.sh | sh
