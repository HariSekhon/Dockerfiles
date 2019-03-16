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
# after all dependencies are built:
# - Ubuntu 331MB
# - CentOS 392MB
# - Debian 632MB
FROM ubuntu:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="DevOps Perl Tools"

ENV DEBIAN_FRONTEND noninteractive

ENV PATH $PATH:/github/tools

RUN mkdir -v /github

WORKDIR /github

RUN export REPOS=tools && \
    apt-get update && apt-get install -y make git curl && \
    curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/git_pull_make_repos.sh | bash && \
    curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/docker_clean.sh | sh

WORKDIR /github/tools

# trying to do -exec basename {} \; results in only the jython files being printed
CMD /bin/bash -c "find /github/tools -maxdepth 1 -type f -iname '[A-Za-z]*.pl' | xargs -n1 basename | sort"
