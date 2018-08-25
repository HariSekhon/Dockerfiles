#
#  Author: Hari Sekhon
#  Date: 2016-01-16 09:58:07 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

# Alpine grep is broken and doesn't detect unbalanced regex parens which breaks tests
#FROM alpine:latest
FROM ubuntu:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="DevOps Perl Tools"

ENV PATH $PATH:/github/tools

RUN mkdir -v /github

WORKDIR /github

RUN bash -c ' \
    set -euxo pipefail && \
    x=tools && \
    #apk add --no-cache git make && \
    apt-get update && apt-get install -y git make && \
    git clone https://github.com/harisekhon/$x /github/$x && \
    cd /github/$x && \
    make build && \
    make apt-packages-remove && \
    make test deep-clean && \
    # leave git for bash-tools/check_pytools.sh
    apt-get remove -y make && \
    apt-get autoremove -y && \
    apt-get clean && \
    bash-tools/check_docker_clean.sh && \
    # basic test for missing dependencies again
    tests/help.sh'

WORKDIR /github/tools

# trying to do -exec basename {} \; results in only the jython files being printed
CMD /bin/bash -c "find /github/tools -maxdepth 1 -type f -iname '[A-Za-z]*.pl' | xargs -n1 basename | sort"
