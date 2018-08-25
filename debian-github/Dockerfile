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

FROM harisekhon/nagios-plugins:debian
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Debian + my GitHub repos pre-built"

ENV PATH $PATH:/github/nagios-plugins:/github/devops-perl-tools:/github/devops-python-tools:/github/bash-tools:/github/spotify

ENV DEBIAN_FRONTEND noninteractive

ENV JAVA_HOME=/usr

RUN mkdir -vp /github

WORKDIR /github

# this is too big and unwieldy and makes caching/maintenance hard
#RUN git clone https://github.com/harisekhon/bash-tools /github/bash-tools && /github/bash-tools/get-my-repos.sh && cd /github/nagios-plugins && make zookeeper && /github/bash-tools/clean-my-repos.sh && apt-get clean

RUN bash -c ' \
    set -euxo pipefail && \
    apt-get update && \
    apt-get install -y make git openjdk-8-jdk scala && \
    echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
    apt-get install -y --no-install-recommends apt-transport-https && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823 && \
    apt-get update && \
    apt-get install -y sbt && \
    apt-get autoremove -y && \
    apt-get clean \
    '

# drops in to /bin/sh pushd not available, could bash -c but explicit paths are good enough
RUN bash -c ' \
    set -euxo pipefail && \
    for x in bash-tools lib tools; do \
        git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build test clean && apt-get autoremove -y && apt-get clean || exit 1; \
    done \
    '
RUN bash -c ' \
     set -euxo pipefail && \
    x=spotify && \
        git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build      clean && apt-get autoremove -y && apt-get clean \
    '

# inherited now
#RUN for x in nagios-plugins;    do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build zookeeper clean || exit 1; done; apt-get autoremove -y && apt-get clean

RUN bash -c ' \
    set -euxo pipefail && \
    for x in pylib pytools; do \
        git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build test clean || exit 1; \
    done && \
    apt-get autoremove -y && \
    apt-get clean && \
    # downgrading certifi package is a workaround so that dockerhub_show_tags.py will work with SSL
    pip uninstall -y certifi && pip install certifi==2015.04.28 \
    '

# could 'make deep-clean' to remove the wrappers and local build libs but it's a trade off between being able to develop quicker by not having to redownload them to recompile
# instead build each project with a different build tool and don't deep-clean so we have them cached for faster development in docker
RUN bash -c 'set -euxo pipefail && x=lib-java &&             git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make gradle test clean && apt-get autoremove -y && apt-get clean'
RUN bash -c 'set -euxo pipefail && x=nagios-plugin-kafka &&  git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make mvn    test clean && apt-get autoremove -y && apt-get clean'
#RUN bash -c 'set -euxo pipefail && x=spark-apps &&          git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make sbt    test clean && apt-get autoremove -y && apt-get clean'

# trick to invalidate cache at this point to pull latest updates
# not needed any more since DockerHub does the build now and doesn't cache anyway
#COPY invalidate_cache /tmp
# pull updates
#RUN /github/bash-tools/update-my-repos.sh && /github/bash-tools/clean-my-repos.sh && apt-get clean
#RUN cd /github/nagios-plugins && make zookeeper && make clean-zookeeper && apt-get clean
#RUN rm -f /tmp/invalidate_cache

COPY profile.d/java.sh /etc/profile.d/

CMD /bin/bash
