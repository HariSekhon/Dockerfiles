#
#  Author: Hari Sekhon
#  Date: 2020-02-08 22:53:37 +0000 (Sat, 08 Feb 2020)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/harisekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

#FROM golang:alpine AS builder
FROM golang:stretch AS builder

WORKDIR /

# awless standard build fetch is broken due to expired SSL cert:
#
#   https://github.com/wallix/awless/issues/278
#
#RUN apt-get update && apt-get install -y curl && \
#RUN #apk add --no-cache bash && \
    #curl https://raw.githubusercontent.com/wallix/awless/master/getawless.sh | sh && \
    #
    # or could download and modify the script
    #wget https://raw.githubusercontent.com/wallix/awless/master/getawless.sh && \
    #...
    #./getawless.sh
    #...
    #chmod +x getawless.sh && \
#   #apt-get purge -y curl && apt-get autoremove -y && apt-get clean -y

# just build straight from source instead

# musl-dev vs libc-dev results in the same size binary
#RUN apk add --no-cache git gcc musl-dev && \
#    go get -ldflags "-linkmode external -extldflags -static" -u github.com/wallix/awless

RUN go get -ldflags "-linkmode external -extldflags -static" -u github.com/wallix/awless

# ============

FROM scratch

MAINTAINER Hari Sekhon (https://www.linkedin.com/in/harisekhon)

LABEL Description="Awless - a Mighty CLI for AWS"

COPY --from=builder /go/bin/awless /awless

ENTRYPOINT ["/awless"]
