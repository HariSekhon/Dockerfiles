#
#  Author: Hari Sekhon
#  Date: 2017-08-22 14:16:43 +0200 (Tue, 22 Aug 2017)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM centos:latest
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="SuperSet (open source Analytics UI by AirBNB)"

WORKDIR /

# TODO: merge this back in to one layer once it's working so dev libs are never saved in the layers
RUN yum upgrade python-setuptools && \
    yum install -y epel-release && \
    yum install -y gcc gcc-c++ libffi-devel python-devel python-pip python-wheel openssl-devel libsasl2-devel openldap-devel mysql-devel

RUN pip install --upgrade setuptools pip && \
    pip install mysqlclient && \
    pip install pyhive && \
    # built on Superset 0.19 originally
    pip install superset && \
    printf "admin\nadmin\nuser\nroot@localhost\nadmin\nadmin\n" | fabmanager create-admin --app superset && \
    superset db upgrade && \
    superset load_examples && \
    superset init
    #yum remove -y gcc gcc-c++ libffi-devel python-devel openssl-devel libsasl2-devel openldap-devel mysql-devel && \
    #yum autoremove -y

EXPOSE 8088

CMD bash -c "/usr/bin/superset runserver -p 8088"
