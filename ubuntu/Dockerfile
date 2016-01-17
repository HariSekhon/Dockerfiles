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

FROM ubuntu
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
    mkdir -v /github

WORKDIR /github

RUN git clone https://github.com/harisekhon/bash-tools /github/bash-tools && /github/bash-tools/get-my-repos.sh

# drops in to /bin/sh pushd not available, could bash -c but explicit paths are good enough
#RUN for x in nagios-plugins tools spotify lib;  do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make || exit 1; done
#RUN for x in pytools pylib;                     do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make || exit 1; done
#RUN for x in spark-apps lib-java;               do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make || exit 1; done

# trick to invalidate cache at this point to pull latest updates
COPY invalidate_cache /tmp
# pull updates
RUN apt-get update && /github/bash-tools/update-my-repos.sh
RUN cd /github/nagios-plugins && make zookeeper
RUN rm -f /tmp/invalidate_cache

CMD /bin/bash
