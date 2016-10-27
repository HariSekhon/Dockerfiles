#
#  Author: Hari Sekhon
#  Date: 2016-01-16 09:58:07 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles/pytools
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM alpine:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Python Tools"

ENV JYTHON_HOME=/opt/jython
ENV PATH $PATH:$JYTHON_HOME/bin:/github/pytools

RUN mkdir -v /github

WORKDIR /github

# downgrading certifi package is a workaround so that dockerhub_show_tags.py will work with SSL
RUN \
    apk add --no-cache make git && \
    # allows numpy to compile with musl instead of glibc
    ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    #py-cffi && \
    x=pytools && \
    git clone https://github.com/harisekhon/$x /github/$x && \
    cd /github/$x && \
    make && \
    pip uninstall -y certifi && pip install certifi==2015.04.28 && \
    make build clean && \
    make apk-packages-remove && \
    apk del make git py-pip

WORKDIR /github/pytools

# Jython
RUN \
    apk update && \
    apk add wget expect && \
    sh jython_install.sh && \
    apk del wget expect

COPY profile.d/java.sh /etc/profile.d/

# trying to do -exec basename {} \; results in only the jython files being printed
CMD /bin/bash -c "find /github/pytools -maxdepth 1 -type f -iname '[A-Za-z]*.py' -o -iname '[A-Za-z]*.jy' | xargs -n1 basename | sort"
