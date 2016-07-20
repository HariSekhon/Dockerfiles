#
#  Author: Hari Sekhon
#  Date: 2016-01-16 09:58:07 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles/tools
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM harisekhon/centos-dev:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Perl Tools repo pre-built on CentOS"

ENV PATH $PATH:/github/tools

RUN mkdir -v /github

WORKDIR /github

# drops in to /bin/sh pushd not available, could bash -c but explicit paths are good enough
RUN x=tools; git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build clean || exit 1; yum autoremove -y && yum clean all

# trying to do -exec basename {} \; results in only the jython files being printed
CMD /bin/bash -c "find /github/tools -maxdepth 1 -type f -iname '[A-Za-z]*.pl' | xargs -n1 basename | sort"
