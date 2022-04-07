# Apache HBase

[![DockerHub HBase](https://img.shields.io/badge/DockerHub-harisekhon%2Fhbase-blue)](https://hub.docker.com/repository/docker/harisekhon/hbase)

https://hbase.apache.org/

Apache HBase NoSQL columnar datastore

Starts a single pseudo-distributed HBase cluster including HBase Master, RegionServer, Thrift Server and Stargate Rest Server.

If started interactively will drop in to an HBase shell.

```
docker run -ti harisekhon/hbase
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
