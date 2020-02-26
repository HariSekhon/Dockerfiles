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

# Alpine grep is broken and doesn't detect unbalanced regex parens which breaks tests
FROM fedora:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="DevOps Perl Tools (Fedora)"

# used by build.sh to figure out which repo to bootstrap
ENV PATH $PATH:/github/perl-tools

COPY build.sh /

RUN /build.sh

WORKDIR /github/perl-tools

# trying to do -exec basename {} \; results in only the jython files being printed
CMD ["/bin/bash", "-c", "find /github/perl-tools -maxdepth 1 -type f -iname '[A-Za-z]*.pl' | xargs -n1 basename | sort"]
