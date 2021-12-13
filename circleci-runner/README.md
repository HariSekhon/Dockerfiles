CircleCI Runner
===============

CircleCI self-hosted runner, with added build dependencies eg. make, python3

Usage:
```
docker run -e CIRCLECI_API_TOKEN=... -e CIRCLECI_RESOURCE_CLASS=<org>/<runner_name> harisekhon/circleci-runner
```

or with docker-compose:

```
export CIRCLECI_API_TOKEN=...
export CIRCLECI_RESOURCE_CLASS=<org>/<runner_name>

docker-compose up
```

Reference Docs:

https://circleci.com/docs/2.0/runner-installation-docker/

https://circleci.com/docs/2.0/runner-on-kubernetes/

# CircleCI Runner on Kubernetes

See https://github.com/HariSekhon/Kubernetes-configs

Related Docker images can be found for many Open Source, Big Data and NoSQL technologies on [my DockerHub profile](https://hub.docker.com/r/harisekhon). The source for them all can be found in the [master Dockerfiles GitHub repo](https://github.com/HariSekhon/Dockerfiles/).
