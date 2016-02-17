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

FROM harisekhon/centos-dev
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG DRILL_VERSION

ENV PATH $PATH:/apache-drill/bin

LABEL Description="Apache Drill" \
      "Apache Drill Version"="$DRILL_VERSION"

# use dev build it's quicker and cached
#RUN yum install -y java-1.7.0-openjdk && yum clean all

RUN yum install -y supervisor && yum clean all

COPY apache-drill-$DRILL_VERSION /apache-drill
COPY drill.ini /etc/supervisord.d/

EXPOSE 8047

#CMD /usr/bin/supervisord -n
CMD /apache-drill/bin/drill-embedded
