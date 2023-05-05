#
#  Author: Hari Sekhon
#  Date: 2016-04-24 21:18:57 +0100 (Sun, 24 Apr 2016)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback
#
#  https://www.linkedin.com/in/HariSekhon
#

# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM harisekhon/github:centos

ARG HADOOP_VERSION=3.0.0

LABEL org.opencontainers.image.description="Hadoop Dev" \
      org.opencontainers.image.version="$HADOOP_VERSION" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/hadoop-dev" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/hadoop-dev" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

ARG TAR=hadoop-$HADOOP_VERSION.tar.gz

ENV PATH $PATH:/hadoop/bin

WORKDIR /

RUN set -eux && \
    yum install -y openssh-server openssh-clients wget tar which

RUN set -eux && \
    yum install -y hostname && \
    # --max-redirect - some apache mirrors redirect a couple times and give you the latest version instead
    #                  but this breaks stuff later because the link will not point to the right dir
    #                  (and is also the wrong version for the tag)
    wget -t 10 --max-redirect 1 --retry-connrefused -O "$TAR" "http://www.apache.org/dyn/closer.lua?filename=hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-$HADOOP_VERSION.tar.gz&action=download" || \
    wget -t 10 --max-redirect 1 --retry-connrefused -O "$TAR" "http://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-$HADOOP_VERSION.tar.gz" && \
    tar zxf "$TAR" && \
    # check tarball was extracted to the right place, helps ensure it's the right version and the link will work
    test -d "hadoop-$HADOOP_VERSION" && \
    ln -sv "hadoop-$HADOOP_VERSION" hadoop && \
    mkdir /etc/hadoop && \
    ln -s /hadoop/etc/hadoop /etc/hadoop/conf && \
    rm -fv "$TAR" && \
    { rm -rf hadoop/share/doc; : ; } && \
    yum autoremove -y && \
    # gets autoremoved, ensure it's added back as Hadoop scripts need it
    yum install -y hostname && \
    yum clean all && \
    rm -rf /var/cache/yum

COPY entrypoint.sh /
COPY conf/core-site.xml /hadoop/etc/hadoop/
COPY conf/hdfs-site.xml /hadoop/etc/hadoop/
COPY conf/yarn-site.xml /hadoop/etc/hadoop/
COPY conf/mapred-site.xml /hadoop/etc/hadoop/
COPY profile.d/hadoop.sh /etc/profile.d/
COPY ssh/config /root/.ssh/

RUN set -eux && \
    # Hadoop 1.x
    #/hadoop/bin/hadoop namenode -format && \
    # Hadoop 2.x
    /hadoop/bin/hdfs namenode -format && \
    groupadd hadoop && \
    useradd -g hadoop hdfs && \
    useradd -g hadoop yarn && \
    mkdir -p /dfs/name && \
    mkdir -p /hadoop/logs && \
    chown -R hdfs:hadoop /dfs/name && \
    chgrp -R hadoop /hadoop/logs && \
    chmod -R 0770 /hadoop/logs && \
    mkdir -p /root/.ssh \
          /home/hdfs/.ssh \
          /home/yarn/.ssh && \
    chown hdfs /home/hdfs/.ssh && \
    chown yarn /home/yarn/.ssh && \
    chmod 0700 /root/.ssh \
               /home/hdfs/.ssh \
               /home/yarn/.ssh

ENV HDFS_NAMENODE_USER=hdfs
ENV HDFS_SECONDARYNAMENODE_USER=hdfs
ENV HDFS_DATANODE_USER=hdfs
ENV YARN_RESOURCEMANAGER_USER=yarn
ENV YARN_NODEMANAGER_USER=yarn

#EXPOSE 8020 8042 8088 9000 10020 19888 50010 50020 50070 50075 50090
# Hadoop 3.0 changed ports :-(
EXPOSE 8020 8042 8088 9000 9868 9870 10020 19888 50010 50020 50090

CMD ["/entrypoint.sh"]
