# CircleCI Runner

[![DockerHub CircleCI Runner](https://img.shields.io/badge/DockerHub-harisekhon%2Fcircleci--runner-blue)](https://hub.docker.com/repository/docker/harisekhon/circleci-runner)

CircleCI self-hosted runner, with added build dependencies eg. make, python3

Usage:
```
docker run -e CIRCLECI_API_TOKEN=... -e CIRCLECI_RESOURCE_CLASS=<namespace>/<resource_class> harisekhon/circleci-runner
```

or with docker-compose:

```
export CIRCLECI_API_TOKEN=...
export CIRCLECI_RESOURCE_CLASS=<namespace>/<resource_class>

docker-compose up
```

Reference Docs:

https://circleci.com/docs/2.0/runner-installation-docker/

https://circleci.com/docs/2.0/runner-on-kubernetes/

# CircleCI Runner on Kubernetes

For a much more advanced example with autoscaling on Kubernetes, see:

https://github.com/HariSekhon/Kubernetes-configs
