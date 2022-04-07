# Presto SQL DB by Facebook

[![DockerHub Presto Dev](https://img.shields.io/badge/DockerHub-harisekhon%2Fpresto--dev-blue)](https://hub.docker.com/repository/docker/harisekhon/presto-dev)

https://prestodb.io/

Distributed interactive high scale SQL engine for Big Data.

Starts a single Presto node which acts as both coordinator and worker and maps port 8080 for nice web UI and driver access.

If started interactively will drop in to a SQL shell.

```
docker-compose up
```

or without `docker-compose`

```
make run
```

Presto-dev includes tagged builds of all development versions of Presto from Facebook's maven repo. Since I don't want another 100+ branches in this repo as there are already over 120 branches for other software, previous versions are re-built only as needed using `build_historic_versions.sh`.

Related Docker images can be found for many Open Source, Big Data and NoSQL technologies on [my DockerHub profile](https://hub.docker.com/r/harisekhon). The source for them all can be found in the [master Dockerfiles GitHub repo](https://github.com/HariSekhon/Dockerfiles/).
