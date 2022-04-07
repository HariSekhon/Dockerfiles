# Apache Drill

[![DockerHub Apache Drill](https://img.shields.io/badge/DockerHub-harisekhon%2Fapache--drill-blue)](https://hub.docker.com/repository/docker/harisekhon/apache-drill)

https://drill.apache.org/

Schema-free SQL Query Engine for Hadoop, NoSQL and Cloud Storage

Starts a single Apache Drillbit and maps port 8047 which you can browse to for Drill UI.

If started interactively will drop in to a SQL shell.

```
docker run -ti -p 8047:8047 harisekhon/apache-drill
```

or with docker-compose:

```
docker-compose up
```

or without `docker-compose`, a shortcut for the docker run command:

```
make run
```

Related Docker images can be found for many Open Source, Big Data and NoSQL technologies on [my DockerHub profile](https://hub.docker.com/r/harisekhon). The source for them all can be found in the [master Dockerfiles GitHub repo](https://github.com/HariSekhon/Dockerfiles/).
