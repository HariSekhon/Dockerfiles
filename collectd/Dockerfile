#
#  Author: Hari Sekhon
#  Date: 2018-01-29 18:07:10 +0000 (Mon, 29 Jan 2018)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM centos:7
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ENV PATH $PATH:/NAME/bin

LABEL Description="Collectd"

WORKDIR /

RUN \
    yum install -y epel-release && \
    yum install -y collectd collectd-write_prometheus collectd-write_tsdb && \
    yum autoremove -y && \
    yum clean all

COPY collectd.conf /etc/collectd.conf

CMD ["/usr/sbin/collectd", "-f"]
