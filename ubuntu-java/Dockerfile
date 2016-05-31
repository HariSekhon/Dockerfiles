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

LABEL Description="Java + Ubuntu (OpenJDK)"

ENV JAVA_HOME=/usr

RUN apt-get update && \
    #apt-get install -y --no-install-recommends openjdk-7-jdk-headless && \
    #apt-get install -y --no-install-recommends openjdk-7-jre-headless && \
    #apt-get install -y --no-install-recommends openjdk-8-jdk-headless && \
    apt-get install -y --no-install-recommends openjdk-8-jre-headless && \
    #apt-get install -y --no-install-recommends openjdk-9-jdk-headless && \
    #apt-get install -y --no-install-recommends openjdk-9-jre-headless && \
    apt-get clean

CMD /bin/bash
