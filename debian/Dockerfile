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

FROM debian
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Debian Dev Build with my GitHub deps"

# drops in to /bin/sh pushd not available, could bash -c but explicit paths are good enough
RUN apt-get update && \
    apt-get install -y git make maven ruby ruby-dev openjdk-7-jdk && \
    # for sbt https repo
    apt-get install -y apt-transport-https && \
    echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823 && \
    apt-get update && \
    apt-get install -y sbt && \
    mkdir /github && \
    for x in nagios-plugins tools pytools pylib lib spotify lib-java spark-apps; do \
        git clone https://github.com/harisekhon/$x /github/$x && \
        cd /github/$x && \
        make || exit 1; \
    done;

WORKDIR /github

CMD /bin/bash
