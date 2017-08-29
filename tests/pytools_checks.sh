#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-09-23 09:16:45 +0200 (Fri, 23 Sep 2016)
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

echo "Dockerfiles PyTools Checks"

pushd "`dirname ${BASH_SOURCE[0]}`/.."

export PATH=$PATH:$PWD/pytools_checks

get_pytools(){
    if ! [ -d pytools_checks ]; then
        git clone https://github.com/harisekhon/pytools pytools_checks
        pushd pytools_checks
        make
        popd
    fi
}

if which dockerfiles_check_git_branches.py &>/dev/null &&
   which git_check_branches_upstream.py &>/dev/null
    then
    if [ -d pytools_checks ]; then
        pushd "$(dirname "$(which dockerfiles_check_git_branches.py)")"
        make update
        popd
    fi
else
    get_pytools
fi

dockerfiles_check_git_branches.py .

git_check_branches_upstream.py .

popd
