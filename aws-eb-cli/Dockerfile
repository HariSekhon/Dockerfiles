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

# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM alpine:3.12

LABEL org.opencontainers.image.description="AWS Elastic Beanstalk CLI" \
      org.opencontainers.image.authors="Hari Sekhon (https://www.linkedin.com/in/HariSekhon)" \
      org.opencontainers.image.url="https://ghcr.io/HariSekhon/aws-eb-cli" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/harisekhon/aws-eb-cli" \
      org.opencontainers.image.source="https://github.com/HariSekhon/Dockerfiles"

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
        'urllib3>=1.26.5' \
        awsebcli && \
    echo && \
    echo "Checking EB CLI runtime..." && \
    echo && \
    eb --help --quiet
        #pip \
        #--upgrade \
        #--ignore-installed \
        #urllib3 \

SHELL ["/bin/bash"]

ENTRYPOINT ["eb"]
