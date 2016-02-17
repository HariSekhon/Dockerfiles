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

FROM harisekhon/centos-jre7
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG TACHYON_VERSION

ENV PATH $PATH:/tachyon/bin

LABEL Description="Tachyon from BDAS" \
      "Tachyon Version"="$TACHYON_VERSION"

# use dev build it's quicker and cached
#RUN yum install -y java-1.7.0-openjdk && yum clean all

COPY tachyon-$TACHYON_VERSION /tachyon
#COPY entrypoint.sh /

RUN yum install -y sudo openssh-server && yum clean all

# Technically shouldn't store the SSH key in the image but this is purely a test driven development image, not prod and not accessible outside
RUN cp -v /tachyon/conf/tachyon-env.sh{.template,} && \
    ssh-keygen -t rsa -b 1024 -f /root/.ssh/id_rsa -N "" && \
    cp -v /root/.ssh/{id_rsa.pub,authorized_keys} && \
    chmod -v 0400 /root/.ssh/authorized_keys && \
    /usr/sbin/sshd-keygen && \
    tachyon format

EXPOSE 19999 30000

#ENTRYPOINT ["/entrypoint.sh"]
CMD /usr/sbin/sshd; sleep 1; tachyon-start.sh local; sleep 2; cat /tachyon/logs/*; tail -f /tachyon/logs/*
