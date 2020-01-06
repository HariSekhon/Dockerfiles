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

LABEL Description="Kafka API Nagios Plugin (Scala, pre-built)"

ENV PATH $PATH:/github/nagios-plugin-kafka

RUN mkdir -v /github

WORKDIR /github

# bash => test scripts
# java => kafka
RUN set -eux && \
    apk add --no-cache bash openjdk8

# hadolint ignore=DL3003
RUN set -eux && \
    apk add --no-cache git make alpine-sdk && \
    x=nagios-plugin-kafka; \
    git clone https://github.com/harisekhon/$x /github/$x && \
    cd /github/$x && \
    make build test && \
    # not using mv as it's as symlink, cp will take the target
    cp -i check_kafka.jar check_kafka.jar2 && \
    # clean removes the link along with the target/build dir
    make deep-clean && \
    mv -i check_kafka.jar2 check_kafka.jar && \
    apk del git make alpine-sdk

WORKDIR /github/nagios-plugin-kafka

CMD ["./check_kafka", "--help"]
