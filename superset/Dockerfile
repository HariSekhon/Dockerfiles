#
#  Author: Hari Sekhon
#  Date: 2017-08-22 14:16:43 +0200 (Tue, 22 Aug 2017)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM centos:8

ARG SUPERSET_VERSION=0.30.1
ARG AVATICA_VERSION=1.17.0

LABEL org.opencontainers.image.description="SuperSet (open source Analytics UI by AirBNB)" \
      org.opencontainers.image.version="$SUPERSET_VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/superset" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/superset" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

WORKDIR /

# Apache Calcite's Avatica JDBC driver for connecting to Druid
RUN mkdir -pv /home/avatica/classpath
ADD https://repository.apache.org/content/groups/public/org/apache/calcite/avatica/avatica-noop-driver/${AVATICA_VERSION}/avatica-noop-driver-${AVATICA_VERSION}.jar /home/avatica/classpath

ENV CLASSPATH=/home/avatica/classpath

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

# Java needed for Apache Calcite's Avatica driver
# hadolint ignore=DL3013
RUN yum install -y epel-release && \
    yum install -y \
        java-headless && \
        gcc \
        gcc-c++ \
        libffi-devel \
        python3-devel \
        python3-pip \
        python3-wheel \
        openssl-devel \
        cyrus-sasl-devel \
        openldap-devel \
        mysql-devel && \
    alternatives --set python /usr/bin/python3 && \
    alternatives --install /usr/bin/pip pip /usr/bin/pip3 100 && \
    # 0.30.1 needs tonnes of Python dependencies when booting superset that are not automatically pulled in, found by iterative testing :-/
    pip install mysqlclient \
                pyhive \
                backoff \
                contextlib2 \
                croniter \
                cryptography \
                flask \
                flask-appbuilder \
                flask-caching \
                flask-compress \
                flask-migrate \
                flask-talisman \
                bleach \
                celery \
                humanize \
                python-geohash \
                geopy \
                isodate \
                markdown \
                msgpack \
                numpy \
                pandas \
                parsedatetime \
                pathlib2 \
                polyline \
                pyarrow \
                retry \
                selenium \
                sqlparse \
                simplejson \
                wtforms-json && \
    # built on Superset 0.19 originally, update tested on 0.30.1
    pip install superset && \
    printf 'admin\nadmin\nuser\nroot@localhost\nadmin\nadmin\n' | \
    superset fab create-admin && \
    superset db upgrade && \
    superset load-examples && \
    superset init && \
    yum remove -y \
        gcc \
        gcc-c++ \
        libffi-devel \
        python-devel \
        openssl-devel \
        cyrus-sasl-devel \
        openldap-devel \
        mysql-devel && \
    yum autoremove -y && \
    curl -sS https://raw.githubusercontent.com/HariSekhon/bash-tools/master/bin/clean_caches.sh | sh && \
    yum clean all && \
    rm -rf /var/cache/yum

EXPOSE 8088

SHELL ["/bin/bash"]

# hadolint ignore=DL3025
CMD /usr/local/bin/superset run -h 0.0.0.0 -p 8088
