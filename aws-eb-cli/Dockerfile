#
#  Author: Hari Sekhon
#  Date: 2022-05-26 11:32:36 +0100 (Thu, 26 May 2022)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

FROM alpine:3.12
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/HariSekhon)

ENV PATH $PATH:/home/aws/.local/bin

SHELL ["/bin/sh", "-eux", "-c"]

# needs Python, Rust, Cargo, Make and various headers and libs to build EB CLI
RUN apk add --no-cache \
    bash \
    cargo \
    gcc \
    libc-dev \
    libffi-dev \
    libressl-dev \
    make \
    py3-pip \
    python3 \
    python3-dev \
    rust
    #linux-headers

RUN adduser -D aws

USER aws

RUN python3 -m pip install \
        --user \
        urllib3==1.24.0 && \
        awsebcli && \
    eb --help --quiet
        #pip \
        #--upgrade \
        #--ignore-installed \
        #urllib3 \

SHELL ["/bin/bash"]

ENTRYPOINT ["eb"]
