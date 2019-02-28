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

FROM harisekhon/nagios-plugins:centos
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="CentOS + my GitHub repos pre-built"

RUN curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/install_sbt_yum.sh | sh && \
    curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/docker_clean.sh | sh

RUN REPOS=bash-tools lib tools \
    curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/get_my_repos.sh | sh && \
    curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/docker_clean.sh | sh

#RUN REPOS=spotify-tools NO_TEST=1 \
#    curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/get_my_repos.sh | sh && \
#    curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/docker_clean.sh | sh

RUN REPOS=pylib pytools \
    curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/get_my_repos.sh | sh && \
    curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/docker_clean.sh | sh
    # downgrading certifi package is a workaround so that dockerhub_show_tags.py will work with SSL
    #pip uninstall -y certifi && pip install certifi==2015.04.28

# could 'make deep-clean' to remove the wrappers and local build libs but it's a trade off between being able to develop quicker by not having to redownload them to recompile
# instead build each project with a different build tool and don't deep-clean so we have them cached for faster development in docker
RUN REPOS=lib-java BUILD=gradle \
    curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/get_my_repos.sh | sh && \
    curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/docker_clean.sh | sh

RUN REPOS=nagios-plugin-kafka BUILD=mvn \
    curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/get_my_repos.sh | sh && \
    curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/docker_clean.sh | sh

#RUN REPOS=spark-apps BUILD=sbt \
#    curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/get_my_repos.sh | sh && \
#    curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/docker_clean.sh | sh

# inherited instead now
#RUN REPOS=nagios-plugins MAKE_OPTS="zookeeper" NO_TEST=1 \
#    curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/get_my_repos.sh | sh && \
#    curl -s https://raw.githubusercontent.com/HariSekhon/bash-tools/master/docker_clean.sh | sh

COPY profile.d/java.sh /etc/profile.d/

ENV JAVA_HOME=/usr

# unit test for lib-java fails when sh is found in /usr/bin/sh as /usr/bin is earlier in the path than /bin
ENV PATH /bin:$PATH:/github/nagios-plugins:/github/devops-perl-tools:/github/devops-python-tools:/github/bash-tools:/github/spotify

WORKDIR /github

CMD /bin/bash
