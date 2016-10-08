#
#  Author: Hari Sekhon
#  Date: 2016-01-16 09:58:07 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles/alpine-github
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

# inherit the nagios-plugins container for less duplication as it's the biggest project
FROM harisekhon/nagios-plugins:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Alpine + my GitHub repos pre-built"

# unit test for lib-java fails when sh is found in /usr/bin/sh as /usr/bin is earlier in the path than /bin
ENV PATH /bin:$PATH:/github/nagios-plugins:/github/tools:/github/pytools:/github/bash-tools:/github/spotify

RUN mkdir -vp /github

WORKDIR /github

# this is too big and unwieldy and makes caching/maintenance hard
#RUN git clone https://github.com/harisekhon/bash-tools /github/bash-tools && /github/bash-tools/get-my-repos.sh && cd /github/nagios-plugins && make zookeeper && /github/bash-tools/clean-my-repos.sh && yum clean all

RUN apk update && apk add make git
# drops in to /bin/sh pushd not available, could bash -c but explicit paths are good enough
RUN for x in bash-tools;        do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build clean || exit 1; done
RUN for x in lib spotify tools; do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build clean apk-packages-remove || exit 1; done
# inherited now
#RUN for x in nagios-plugins;    do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build zookeeper clean apk-packages-remove || exit 1; done
# downgrading certifi package is a workaround so that dockerhub_show_tags.py will work with SSL
RUN \
    # allows numpy to compile with musl instead of glibc
    ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    for x in pylib pytools; do \
        git clone https://github.com/harisekhon/$x /github/$x && \
        cd /github/$x && \
        make build clean apk-packages-remove || exit 1;\
    done; \
    pip uninstall -y certifi && \
    pip install certifi==2015.04.28
RUN x=lib-java; apk update && apk add bash openjdk8 alpine-sdk; git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build deep-clean
#RUN for x in spark-apps;        do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make build clean apk-packages-remove || exit 1; done

COPY profile.d/java.sh /etc/profile.d/

CMD /bin/bash
