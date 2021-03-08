Jenkins inbound-agent + Docker
==============================

Jenkins inbound agent + docker.io package installed to be able to use the `docker` command (combine with mounting docker socket for running builds inside docker containers).

https://hub.docker.com/r/jenkins/inbound-agent/

Using the stock image the default Jenkins attempt to use docker will fail with this error:

```
/home/jenkins/agent/workspace/<name>@tmp/durable-2f6d01c2/script.sh: 1: /home/jenkins/agent/workspace/<name>@tmp/durable-2f6d01c2/script.sh: docker: not found
```
