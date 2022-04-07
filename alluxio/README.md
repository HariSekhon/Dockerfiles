# Alluxio

[![DockerHub Alluxio](https://img.shields.io/badge/DockerHub-harisekhon%2Falluxio-blue)](https://hub.docker.com/repository/docker/harisekhon/alluxio)

http://www.alluxio.org/

Distributed in-memory filesystem for cluster computing frameworks, formerly called Tachyon (older versions are found under harisekhon/tachyon and the tachyon directory adjacent in this repo)

Starts one master and one worker and then tails the logs, maps the master and worker ports 19999 and 30000.

```
docker-compose up
```

or without `docker-compose`

```
make run
```

Related Docker images can be found for many Open Source, Big Data and NoSQL technologies on [my DockerHub profile](https://hub.docker.com/r/harisekhon). The source for them all can be found in the [master Dockerfiles GitHub repo](https://github.com/HariSekhon/Dockerfiles/).
