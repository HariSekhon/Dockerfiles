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

FROM ubuntu:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Bash Tools"

# used by build.sh to figure out which repo to bootstrap
ENV PATH $PATH:/github/bash-tools

COPY build.sh /

RUN /build.sh

WORKDIR /github/bash-tools

CMD ["/bin/bash", "-c", "find /github/bash-tools -maxdepth 1 -type f -iname '[A-Za-z]*.sh' | xargs -n1 basename | sort"]
