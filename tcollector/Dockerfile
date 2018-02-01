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

ENV PATH $PATH:/tcollector:/usr/local/tcollector

LABEL Description="OpenTSDB TCollector"

WORKDIR /

RUN \
    yum install -y python && \
    # 1.3.0 seems to have no collectors and therefore sends no metrics to OpenTSDB, must use latest release from GitHub
    #yum install -y https://github.com/OpenTSDB/tcollector/releases/download/v1.3.0/tcollector-1.3.0-1.noarch.rpm && \
    yum install -y git && \
    git clone https://github.com/OpenTSDB/tcollector /tcollector && \
    yum autoremove -y && \
    yum clean all && \
    rm -rf /var/cache/yum

# RPM
#ENV TCOLLECTOR_HOME="/usr/local/tcollector"
# GIT
ENV TCOLLECTOR_HOME="/tcollector"

# RPM
#CMD ["/usr/local/tcollector/tcollector.py", "-H", "opentsdb", "-c", "/usr/local/tcollector/collectors", "--logfile", "/dev/stdout", "--pidfile", "/tmp/tcollector.pid"]

# GIT
CMD ["/tcollector/tcollector.py", "-H", "opentsdb", "-c", "/tcollector/collectors", "--logfile", "/dev/stdout", "--pidfile", "/tmp/tcollector.pid"]
