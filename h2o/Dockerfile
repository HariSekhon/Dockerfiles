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

#FROM harisekhon/centos-jre7
# > 100MB smaller than centos
FROM harisekhon/debian-jre7
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

#ARG H2O_VERSION=2.6.1.5
#ARG H2O_VERSION=3.8.0.4
ARG H2O_VERSION=3.8.2.3

ENV PATH $PATH:/h2o/bin

LABEL Description="H2O" \
      "0xData H2O Version"="$H2O_VERSION"

#COPY h2o-$H2O_VERSION /h2o

RUN \
    apt-get update && \
    apt-get install -y wget unzip && \
    cd / && \
    wget http://download.h2o.ai/versions/h2o-${H2O_VERSION}.zip && \
    unzip h2o-${H2O_VERSION}.zip && \
    rm h2o-${H2O_VERSION}.zip && \
    apt-get purge -y wget unzip && \
    apt-get autoremove -y && \
    apt-get clean

EXPOSE 54321

CMD java -jar /h2o/h2o.jar
