#
#  Author: Hari Sekhon
#  Date: 2021-12-06 16:44:16 +0000 (Mon, 06 Dec 2021)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

FROM alpine/git:v2.32.0
MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

ARG KUSTOMIZE_VERSION=4.4.1

WORKDIR /

RUN set -eux && \
    apk add --no-cache ca-certificates && \
    wget -O /tmp/kustomize.tgz "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz" && \
    tar zxvf /tmp/kustomize.tgz kustomize -O > /usr/local/bin/kustomize && \
    chmod +x /usr/local/bin/kustomize

ENTRYPOINT ["sh"]
