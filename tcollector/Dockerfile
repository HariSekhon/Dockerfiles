#
#  Author: Hari Sekhon
#  Date: 2018-01-30 16:15:34 +0000 (Tue, 30 Jan 2018)
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

ENV PATH $PATH:/tcollector/bin

LABEL Description="OpenTSDB TCollector"

WORKDIR /

RUN \
    yum install -y git python && \
    git clone https://github.com/OpenTSDB/tcollector /tcollector && \
    yum autoremove -y && \
    yum clean all && \
    rm -rf /var/cache/yum

CMD ["/tcollector/tcollector.py", "-H", "opentsdb", "-c", "/tcollector/collectors", "--logfile", "/dev/stdout",  "--pidfile", "/tmp/tcollector.pid"]
