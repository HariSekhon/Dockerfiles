#
#  Author: Hari Sekhon
#  Date: 2016-01-16 09:58:07 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles/ubuntu-github
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM harisekhon/ubuntu-dev:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Ubuntu + my GitHub repos pre-built"

ENV PATH $PATH:/github/nagios-plugins:/github/tools:/github/pytools:/github/bash-tools:/github/spotify

RUN mkdir -v /github

WORKDIR /github

# this is too big and unwieldy and makes caching/maintenance hard
#RUN git clone https://github.com/harisekhon/bash-tools /github/bash-tools && /github/bash-tools/get-my-repos.sh && cd /github/nagios-plugins && make zookeeper && /github/bash-tools/clean-my-repos.sh && apt-get clean

# drops in to /bin/sh pushd not available, could bash -c but explicit paths are good enough
RUN for x in bash-tools;        do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build clean || exit 1; done; apt-get autoremove -y && apt-get clean
RUN for x in lib spotify tools; do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build clean || exit 1; done; apt-get autoremove -y && apt-get clean
RUN for x in nagios-plugins;    do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build zookeeper clean || exit 1; done; apt-get autoremove -y && apt-get clean
# downgrading certifi package is a workaround so that dockerhub_show_tags.py will work with SSL
RUN for x in pylib pytools;     do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build clean || exit 1; done; apt-get autoremove -y && apt-get clean && pip uninstall -y certifi && pip install certifi==2015.04.28
RUN for x in lib-java;          do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make mvn deep-clean || exit 1; done; apt-get autoremove -y && apt-get clean
RUN for x in spark-apps nagios-plugin-kafka; do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make mvn clean || exit 1; done; apt-get autoremove -y && apt-get clean

# trick to invalidate cache at this point to pull latest updates
#COPY invalidate_cache /tmp
# pull updates
#RUN /github/bash-tools/update-my-repos.sh && /github/bash-tools/clean-my-repos.sh && apt-get clean
#RUN cd /github/nagios-plugins && make zookeeper && make clean-zookeeper && apt-get clean
#RUN rm -f /tmp/invalidate_cache

CMD /bin/bash
