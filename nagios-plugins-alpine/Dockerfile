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

FROM alpine:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Advanced Nagios Plugins Collection"

COPY build.sh /

# drops in to /bin/sh pushd not available, could bash -c but explicit paths are good enough
RUN apk add --no-cache bash && /build.sh

# Cache Bust upon new commits
RUN curl -sS https://api.github.com/repos/HariSekhon/Nagios-Plugins/git/refs/heads/master | jq -r .object.sha > /.git-hashref

RUN /build.sh

#ADD http://date.jsontest.com /etc/builddate
#ADD http://worldclockapi.com/api/json/utc/now /etc/builddate

ENV PATH $PATH:/github/nagios-plugins

WORKDIR /github/nagios-plugins

COPY list_plugins.sh /

CMD ["/list_plugins.sh"]
