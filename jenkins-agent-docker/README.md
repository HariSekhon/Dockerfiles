# Jenkins inbound-agent + Docker

[![DockerHub Jenkins Agent](https://img.shields.io/badge/DockerHub-harisekhon%2Fjenkins--agent--docker-blue)](https://hub.docker.com/repository/docker/harisekhon/jenkins-agent-docker)

Jenkins inbound agent + docker packages installed to be able to use the `docker` and `docker-compose` commands (combine with mounting docker socket).

This is known as Docker-out-of-Docker (DooD), which allows running docker commands inside the Jenkins agent's CI/CD builds, creating sibling docker containers.

```
docker run -ti -u 0 -v /var/run/docker.sock:/var/run/docker.sock harisekhon/jenkins-agent-docker bash

# inside the jenkins agent you can then run docker commands like normal and in your CI/CD builds
docker ps
...
```

This docker image solves the lack of `docker` command availability in the stock [jenkins/inbound-agent](https://hub.docker.com/r/jenkins/inbound-agent/) image (see issues [#215](https://github.com/jenkinsci/docker-inbound-agent/issues/215) and [#222](https://github.com/jenkinsci/docker-inbound-agent/issues/222))

```
/home/jenkins/agent/workspace/<name>@tmp/durable-2f6d01c2/script.sh: docker: not found
```

If doing DooD, beware it lacks isolation and should only be done in trusted environments where nobody has access to create or edit naughty Jenkins builds.

For more discussion of DooD vs DinD, see this article:

http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/

### Kubernetes

For Jenkins on Kubernetes, see:

https://github.com/HariSekhon/Kubernetes-templates
