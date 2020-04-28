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

FROM centos:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Advanced Nagios Plugins Collection (CentOS build)"

COPY build.sh /

RUN /build.sh

#ADD http://date.jsontest.com /etc/builddate
ADD http://worldclockapi.com/api/json/utc/now /etc/builddate

# get updates, faster rebuild
RUN /build.sh

ENV PATH $PATH:/github/nagios-plugins

WORKDIR /github/nagios-plugins

COPY list_plugins.sh /

CMD ["/list_plugins.sh"]
