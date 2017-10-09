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

# Alpine's underlying libraries are causing find_active_server.py --https mode to run all threads concurrently without respecting the --num causing indeterministic results and failing tests/test_find_active_server.sh
#FROM alpine:latest
FROM ubuntu:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Python Tools"

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -v /github

WORKDIR /github

# downgrading certifi package is a workaround so that dockerhub_show_tags.py will work with SSL
#RUN set -euxo pipefail && \
    #apk add --no-cache make git && \
    # allows numpy to compile with musl instead of glibc
    #ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    #py-cffi && \
RUN bash -c ' \
    set -euxo pipefail && \
    apt-get update && \
    apt-get install -y make git && \
    x=pytools && \
    git clone https://github.com/harisekhon/$x /github/$x && \
    cd /github/$x && \
    NOJAVA=1 make && \
    pip uninstall -y certifi && pip install certifi==2015.04.28 && \
    make apt-packages-remove && \
    apt-get autoremove -y && \
    apt-get clean && \
    make test deep-clean && \
    # leave git package as some tools use git
#    apk del make py-pip
    apt-get purge -y make && \
    apt-get autoremove -y && \
    apt-get clean && \
    bash-tools/check_docker_clean.sh \
    # fails after make clean as local spark installations are removed
    # basic test for missing dependencies again
    #tests/help.sh
    '

WORKDIR /github/pytools

# Jython
#
# Not realistically gonna use Hadoop Jython utils from docker when they need -Jcp `hadoop classpath` anyway, leave it for harisekhon/hadoop-dev docker image
#
#RUN bash -c ' \
#    set -euxo pipefail && \
#    apt-get install -y wget expect && \
#    sh jython_install.sh && \
#    apt-get purge -y wget expect && \
#    apt-get autoremove -y && \
#    apt-get clean \
#    '

#ENV JYTHON_HOME=/opt/jython
#ENV PATH $PATH:$JYTHON_HOME/bin:/github/pytools
ENV PATH $PATH:/github/pytools

#COPY profile.d/java.sh /etc/profile.d/

# trying to do -exec basename {} \; results in only the jython files being printed
CMD /bin/bash -c "find /github/pytools -maxdepth 1 -type f -iname '[A-Za-z]*.py' -o -iname '[A-Za-z]*.jy' | xargs -n1 basename | sort"
