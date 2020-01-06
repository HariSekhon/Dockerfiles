#
#  Author: Hari Sekhon
#  Date: 2019-10-21 17:24:49 +0100 (Mon, 21 Oct 2019)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM ruby:2.6.5-alpine
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="FakeS3"

RUN set -ex && \
    mkdir -pv /data && \
    gem install fakes3

WORKDIR /data

EXPOSE 4567

ENTRYPOINT ["fakes3", "-r", "/data", "-p", "4567", "--license"]
