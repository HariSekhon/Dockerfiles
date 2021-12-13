CircleCI Runner
===============

https://circleci.com/docs/2.0/runner-installation-docker/

https://circleci.com/docs/2.0/runner-on-kubernetes/

CircleCI self-hosted runner

```
docker run -e CIRCLECI_API_TOKEN=... -e CIRCLECI_RESOURCE_CLASS=<org>/<runner_name> harisekhon/circleci-runner
```

```
export CIRCLECI_API_TOKEN=...
export CIRCLECI_RESOURCE_CLASS=<org>/<runner_name>

docker-compose up
```

Related Docker images can be found for many Open Source, Big Data and NoSQL technologies on [my DockerHub profile](https://hub.docker.com/r/harisekhon). The source for them all can be found in the [master Dockerfiles GitHub repo](https://github.com/HariSekhon/Dockerfiles/).
