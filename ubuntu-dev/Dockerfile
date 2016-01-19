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

FROM ubuntu:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Ubuntu Dev Build with my GitHub deps"

RUN apt-get update && \
    apt-get install -y git make maven ruby ruby-dev openjdk-7-jdk vim && \
    # for sbt https repo
    apt-get install -y apt-transport-https && \
    echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823 && \
    apt-get update && \
    apt-get install -y sbt && \
    # for Maven 3
    #echo deb http://ppa.launchpad.net/natecarlson/maven3/ubuntu precise main >> /etc/apt/sources.list && \
    #apt-get update && \
    #apt-get install -y maven && \
    apt-get clean && \
    mkdir -v /github

WORKDIR /github

# this is too big and unwieldy and makes caching/maintenance hard
#RUN git clone https://github.com/harisekhon/bash-tools /github/bash-tools && /github/bash-tools/get-my-repos.sh && cd /github/nagios-plugins && make zookeeper && /github/bash-tools/clean-my-repos.sh && apt-get clean

# drops in to /bin/sh pushd not available, could bash -c but explicit paths are good enough
RUN for x in bash-tools;        do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build clean || exit 1; done; apt-get clean
RUN for x in lib spotify tools; do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build clean || exit 1; done; apt-get clean
RUN for x in nagios-plugins;    do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build zookeeper clean || exit 1; done; apt-get clean
RUN for x in pylib pytools;     do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build clean || exit 1; done; apt-get clean
RUN for x in lib-java;          do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build clean || exit 1; done; apt-get clean
RUN for x in spark-apps;        do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build clean || exit 1; done; apt-get clean

# trick to invalidate cache at this point to pull latest updates
#COPY invalidate_cache /tmp
# pull updates
#RUN /github/bash-tools/update-my-repos.sh && /github/bash-tools/clean-my-repos.sh && apt-get clean
#RUN cd /gthub/nagios-plugins && make zookeeper && make clean-zookeeper
#RUN rm -f /tmp/invalidate_cache

CMD /bin/bash
