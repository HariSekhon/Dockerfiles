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

FROM centos
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="CentOS Dev Build with my GitHub deps"

RUN yum install -y git make maven ruby ruby-devel java-1.7.0-openjdk && \
    curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo && \
    yum install -y sbt && \
    # workaround for CentOS (found via strace) otherwise incorrectly states "Warning: You do not have write permission for Perl library directories." and local::lib hits use of uninitialized variables errors in base modules like even core File::Basename :-/
    mkdir -v /usr/local/share/perl5 /usr/local/lib64/perl5 && \
    mkdir -v /github

RUN git clone https://github.com/harisekhon/bash-tools /github/bash-tools && /github/bash-tools/get-my-repos.sh

# drops in to /bin/sh pushd not available, could bash -c but explicit paths are good enough
#RUN for x in nagios-plugins tools spotify lib;  do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make || exit 1; done
#RUN for x in pytools pylib;                     do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make || exit 1; done
#RUN for x in spark-apps lib-java;               do git clone https://github.com/harisekhon/$x /github/$x && cd /github/$x && make || exit 1; done

# trick to invalidate cache at this point to pull latest updates
COPY invalidate_cache /tmp
# pull updates
RUN rm -f /tmp/invalidate_cache; /github/bash-tools/update-my-repos.sh

WORKDIR /github

CMD /bin/bash
