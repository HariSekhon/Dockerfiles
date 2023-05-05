#
#  Author: Hari Sekhon
#  Date: 2016-01-16 09:58:07 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM centos:8

LABEL org.opencontainers.image.description="Python Tools (CentOS)" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/pytools" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/pytools" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

#ENV JYTHON_HOME=/opt/jython
#ENV PATH $PATH:$JYTHON_HOME/bin:/github/devops-python-tools

# used by build.sh to figure out which repo to bootstrap
ENV PATH $PATH:/github/pytools:/github/pytools/bash-tools

# not using Alpine any more
# downgrading certifi package is a workaround so that dockerhub_show_tags.py will work with SSL
#RUN set -euxo pipefail && \
    #apk add --no-cache make git && \
    # allows numpy to compile with musl instead of glibc
    #ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    #py-cffi && \

ADD https://raw.githubusercontent.com/HariSekhon/DevOps-Bash-tools/master/setup/docker_bootstrap.sh /build.sh

RUN chmod +x /build.sh && NO_TESTS=1 /build.sh
    # downgrading certifi package is a workaround so that dockerhub_show_tags.py will work with SSL
    #pip uninstall -y certifi && pip install certifi==2015.04.28

# Cache Bust upon new commits
ADD https://api.github.com/repos/HariSekhon/DevOps-Python-tools/git/refs/heads/master /.git-hashref

ADD https://raw.githubusercontent.com/HariSekhon/Dockerfiles/master/src/list_python_jython.sh /list.sh

# 2nd run is almost a noop without cache, and only an incremental update upon cache bust
RUN chmod +x /list.sh && /build.sh

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
#    curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/clean_caches.sh | sh
#    rm -f jython_install.sh jython_autoinstall.exp

#COPY profile.d/java.sh /etc/profile.d/

CMD ["/list.sh", "/github/pytools"]
