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
FROM fedora:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Python Tools"

#ENV JYTHON_HOME=/opt/jython
#ENV PATH $PATH:$JYTHON_HOME/bin:/github/devops-python-tools

# used by build.sh to figure out which repo to bootstrap
ENV PATH $PATH:/github/pytools

# not using Alpine any more
# downgrading certifi package is a workaround so that dockerhub_show_tags.py will work with SSL
#RUN set -euxo pipefail && \
    #apk add --no-cache make git && \
    # allows numpy to compile with musl instead of glibc
    #ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    #py-cffi && \

COPY build.sh /

RUN /build.sh
    # downgrading certifi package is a workaround so that dockerhub_show_tags.py will work with SSL
    #pip uninstall -y certifi && pip install certifi==2015.04.28

WORKDIR /github/pytools

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

# trying to do -exec basename {} \; results in only the jython files being printed
CMD ["/bin/bash", "-c", "find /github/pytools -maxdepth 1 -type f -iname '[A-Za-z]*.py' -o -iname '[A-Za-z]*.jy' | xargs -n1 basename | sort"]
