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

#FROM harisekhon/centos-java:jre7
# > 100MB smaller than centos
FROM harisekhon/debian-java:jre7
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG H2O_VERSION=3.10.0.3

ENV PATH $PATH:/h2o/bin

LABEL Description="H2O" \
      "0xData H2O Version"="$H2O_VERSION"

ENV DEBIAN_FRONTEND noninteractive

#COPY h2o-$H2O_VERSION /h2o

WORKDIR /

RUN bash -c ' \
    set -euxo pipefail && \
    apt-get update && \
    apt-get install -y --no-install-recommends wget unzip && \
    # 2.6.1.5
    #wget -t 100 --retry-connrefused http://h2o-release.s3.amazonaws.com/h2o/rel-lambert/5/h2o-${H2O_VERSION}.zip && \
    # 3.x url has changed
    wget -t 100 --retry-connrefused http://download.h2o.ai/versions/h2o-${H2O_VERSION}.zip && \
    unzip h2o-${H2O_VERSION}.zip && \
    rm h2o-${H2O_VERSION}.zip && \
    ln -s h2o-${H2O_VERSION} h2o && \
    apt-get purge -y wget unzip && \
    apt-get autoremove -y && \
    apt-get clean'

EXPOSE 54321

CMD ["java", "-jar", "/h2o/h2o.jar"]
