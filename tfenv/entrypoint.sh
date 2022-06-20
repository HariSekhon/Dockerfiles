#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2022-06-20 15:51:43 +0100 (Mon, 20 Jun 2022)
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

TFENV_TERRAFORM_VERSION="${TERRAFORM_VERSION:-${TFENV_TERRAFORM_VERSION:-latest}}"

#if ! tfenv list &>/dev/null; then
if ! tfenv version-name &>/dev/null; then
    tfenv install
fi

terraform "$@"
