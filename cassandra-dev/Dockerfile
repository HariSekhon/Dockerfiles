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

# can't base off Cassandra as it's missing deps to run the tools
#FROM cassandra
FROM harisekhon/nagios-plugins
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG CASSANDRA_VERSION=22

LABEL Description="Cassandra Dev"

COPY datastax.repo /etc/yum.repos.d/datastax.repo

RUN yum install -y make git cassandra$CASSANDRA_VERSION && yum clean all

#RUN git clone https://github.com/harisekhon/nagios-plugins /nagios-plugins && \
#    cd /nagios-plugins && \
#    make && \
#    yum clean all

EXPOSE 7199 9042 9160

COPY entrypoint.sh /

CMD /entrypoint.sh
