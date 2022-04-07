# Apache HBase + Dev Tools

[![DockerHub HBase Dev](https://img.shields.io/badge/DockerHub-harisekhon%2Fhvase--dev-blue)](https://hub.docker.com/repository/docker/harisekhon/hbase-dev)

https://hbase.apache.org/

Apache HBase NoSQL columnaredatastore plus all the programming languages development tools listed on the [main page](https://github.com/HariSekhon/Dockerfiles/#base-images) and all my [GitHub repos](https://github.com/harisekhon) with all dependencies pre-built for easy development and testing.

Starts a single pseudo-distributed HBase cluster including HBase Master, RegionServer, Thrift Server and Stargate Rest Server.

If started interactively will drop in to an HBase shell.

```
docker run -ti harisekhon/hbase-dev
```

There are a lot of ports, so if you want to start the container and map all of them, use docker-compose:

```
docker-compose up
```

or without `docker-compose`, a shortcut for the docker run command with all port mapping switches:

```
make run
```

The HBase root dir is located at `/hbase-data` and is exported as a standard Docker Volume for data management.

Related Docker images can be found for many Open Source, Big Data and NoSQL technologies on [my DockerHub profile](https://hub.docker.com/r/harisekhon). The source for them all can be found in the [master Dockerfiles GitHub repo](https://github.com/HariSekhon/Dockerfiles/).
