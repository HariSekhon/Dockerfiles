Jenkins inbound-agent + Docker
==============================

Jenkins inbound agent + docker.io package installed to be able to use the `docker` command (combine with mounting docker socket).

This is known as Docker-outside-of-Docker (DooD), which allows running docker commands inside the Jenkins CI/CD builds that run on the agent.

To give the Jenkins agent container access to the parent Docker host to create sibling containers, you must use this image and mount the `docker.sock` and as well as run the container as root (bad practices but it works - you should only do this in a trusted environment where people running build commands on the Jenkins agent are trusted to not be naughty)

```
docker run -ti -u 0 -v /var/run/docker.sock:/var/run/docker.sock harisekhon/jenkins-agent-docker bash

# inside the jenkins agent you can then run docker commands like normal
docker ps
...
```

Solves this problem you'll see when using the stock [jenkins/inbound-agent](https://hub.docker.com/r/jenkins/inbound-agent/) image, as documented in https://github.com/jenkinsci/docker-inbound-agent/issues/215:

```
/home/jenkins/agent/workspace/<name>@tmp/durable-2f6d01c2/script.sh: docker: not found
```

For more discussion of this, see this article:

http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/
