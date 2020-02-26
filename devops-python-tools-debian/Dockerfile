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
FROM debian:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Python Tools (Debian)"

ENV DEBIAN_FRONTEND noninteractive

#ENV JYTHON_HOME=/opt/jython
#ENV PATH $PATH:$JYTHON_HOME/bin:/github/devops-python-tools

# used by build.sh to figure out which repo to bootstrap
ENV PATH $PATH:/github/pytools

COPY build.sh /

RUN /build.sh

# Jython
#
# Not realistically gonna use Hadoop Jython utils from docker when they need -Jcp `hadoop classpath` anyway, leave it for harisekhon/hadoop-dev docker image
#
#RUN set -euxo pipefail && \
#    yum install -y wget expect && \
#    wget https://raw.githubusercontent.com/HariSekhon/devops-python-tools/master/jython_install.sh && \
#    wget https://raw.githubusercontent.com/HariSekhon/devops-python-tools/master/jython_autoinstall.exp && \
#    bash jython_install.sh && \
#    yum remove -y wget expect && \
#    curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/docker_clean.sh | sh
#    rm -f jython_install.sh jython_autoinstall.exp

#COPY profile.d/java.sh /etc/profile.d/

WORKDIR /github/pytools

# trying to do -exec basename {} \; results in only the jython files being printed
CMD ["/bin/bash", "-c", "find /github/pytools -maxdepth 1 -type f -iname '[A-Za-z]*.py' -o -iname '[A-Za-z]*.jy' | xargs -n1 basename | sort"]
