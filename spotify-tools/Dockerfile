#
#  Author: Hari Sekhon
#  Date: 2016-01-16 09:58:07 +0000 (Sat, 16 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles/spotify-tools
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM alpine:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Spotify Tools"

ENV PATH $PATH:/github/spotify-tools

RUN mkdir -v /github

WORKDIR /github

RUN \
    x=spotify-tools; \
    apk update && \
    apk add bash make git perl perl-dev gcc wget alpine-sdk openssl-dev expat-dev && \
    git clone https://github.com/harisekhon/$x /github/$x && \
    cd /github/$x && \
    make build clean && \
    apk del make git perl-dev gcc wget alpine-sdk openssl-dev expat-dev
    # cache not enabled
    #apk cache clean

WORKDIR /github/spotify-tools

# trying to do -exec basename {} \; results in only the jython files being printed
CMD sh -c "find /github/spotify-tools -maxdepth 1 -type f -name '[A-Za-z]*.pl' | xargs -n1 basename | sort"
