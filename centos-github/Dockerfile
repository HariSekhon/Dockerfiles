#
#  Author: Hari Sekhon
#  Date: 2016-01-16 09:58:07 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles/centos-github
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM harisekhon/centos-dev:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="CentOS + my GitHub repos pre-built"

# unit test for lib-java fails when sh is found in /usr/bin/sh as /usr/bin is earlier in the path than /bin
ENV PATH /bin:$PATH:/github/nagios-plugins:/github/tools:/github/pytools:/github/bash-tools:/github/spotify

RUN mkdir -vp /github

WORKDIR /github

# this is too big and unwieldy and makes caching/maintenance hard
#RUN git clone https://github.com/harisekhon/bash-tools /github/bash-tools && /github/bash-tools/get-my-repos.sh && cd /github/nagios-plugins && make zookeeper && /github/bash-tools/clean-my-repos.sh && yum clean all

# drops in to /bin/sh pushd not available, could bash -c but explicit paths are good enough
RUN for x in bash-tools;        do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build clean || exit 1; done; yum autoremove -y && yum clean all
RUN for x in lib spotify tools; do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build clean || exit 1; done; yum autoremove -y && yum clean all
RUN for x in nagios-plugins;    do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build zookeeper clean || exit 1; done; yum autoremove -y && yum clean all
# downgrading certifi package is a workaround so that dockerhub_show_tags.py will work with SSL
RUN for x in pylib pytools;     do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build clean || exit 1; done; yum autoremove -y && yum clean all && pip uninstall -y certifi && pip install certifi==2015.04.28
RUN for x in lib-java;          do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build clean || exit 1; done; yum autoremove -y && yum clean all
RUN for x in spark-apps;        do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build clean || exit 1; done; yum autoremove -y && yum clean all

# trick to invalidate cache at this point to pull latest updates
# not needed any more since DockerHub does the build now and doesn't cache anyway
#COPY invalidate_cache /tmp
# pull updates
#RUN /github/bash-tools/update-my-repos.sh && /github/bash-tools/clean-my-repos.sh && yum clean all
#RUN cd /github/nagios-plugins && make zookeeper && make clean-zookeeper
#RUN rm -f /tmp/invalidate_cache

CMD /bin/bash
