Jenkins inbound-agent + Docker
==============================

Jenkins inbound agent + docker.io package installed to be able to use the `docker` command (combine with mounting docker socket for running builds inside docker containers).

https://hub.docker.com/r/jenkins/inbound-agent/

Solves this problem you'll see when using the stock [jenkins/inbound-agent](https://hub.docker.com/r/jenkins/inbound-agent/) image, as documented in https://github.com/jenkinsci/docker-inbound-agent/issues/215:

```
/home/jenkins/agent/workspace/<name>@tmp/durable-2f6d01c2/script.sh: docker: not found
```
