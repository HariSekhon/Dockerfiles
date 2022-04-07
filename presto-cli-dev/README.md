# Presto SQL CLI by Facebook

[![DockerHub Presto CLI Dev](https://img.shields.io/badge/DockerHub-harisekhon%2Fpresto--cli--dev-blue)](https://hub.docker.com/repository/docker/harisekhon/presto-cli-dev)

https://prestodb.io/

SQL Client for Presto DB - the distributed interactive high scale SQL engine for Big Data.

This includes tagged builds of all development versions of Presto from Facebook's maven repo. Since I don't want another 100+ branches in this repo as there are already over 120 branches for other software, previous versions are re-built only as needed using `build_historic_versions.sh`.

See adjacent `presto-dev` directory for the corresponding DB engine build (which also contains this client for convenience as it opens an interactive SQL shell if started interactively).

Related Docker images can be found for many Open Source, Big Data and NoSQL technologies on [my DockerHub profile](https://hub.docker.com/r/harisekhon). The source for them all can be found in the [master Dockerfiles GitHub repo](https://github.com/HariSekhon/Dockerfiles/).
