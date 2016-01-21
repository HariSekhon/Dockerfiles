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
#  http://www.linkedin.com/in/harisekhon
#

FROM harisekhon/centos-dev:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="CentOS 7 with my PyTools pre-built"

ENV PATH $PATH:/github/pytools

RUN mkdir -v /github

WORKDIR /github

# this is too big and unwieldy and makes caching/maintenance hard
#RUN git clone https://github.com/harisekhon/bash-tools /github/bash-tools && /github/bash-tools/get-my-repos.sh && cd /github/nagios-plugins && make zookeeper && /github/bash-tools/clean-my-repos.sh && yum clean all

# drops in to /bin/sh pushd not available, could bash -c but explicit paths are good enough
RUN x=pytools; git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build clean || exit 1; yum clean all

# trying to do -exec basename {} \; results in only the jython files being printed
CMD /bin/bash -c "find /github/pytools -maxdepth 1 -type f -iname '[A-Za-z]*.py' -o -iname '[A-Za-z]*.jy' | xargs -n1 basename | sort"
