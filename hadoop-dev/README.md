# Apache Hadoop

[![DockerHub Hadoop Dev](https://img.shields.io/badge/DockerHub-harisekhon%2Fhadoop--dev-blue)](https://hub.docker.com/repository/docker/harisekhon/hadoop-dev)

https://hadoop.apache.org/

Big Data Distributed Storage and Compute Software

- Yarn - Distributed Processing Framework for running MapReduce, Spark and other application frameworks
- HDFS - Distributed Storage

By default starts a pseudo-distributed cluster of 4 daemons in a single container:

- Yarn
  - ResourceManager - Cluster Processing Master (submit jobs here)
  - NodeManager - Cluster Processing Worker
- HDFS
  - NameNode - Filesystem Master
  - DataNode - Filesystem Worker

Perfect for development and testing. Recommended to use Docker with 4GB+ RAM for this pseudo-cluster container.

For real scaling just start a single daemon in each container for fully distributed setup.


To run the all-in-one-container cluster and expose all the UIs for NodeManager, ResourceManager, Job History, DataNode and NameNode respectively, do:
```
docker run -ti -p 8042 -p 8088 -p 19888 -p 9064 -p 9070 harisekhon/hadoop-dev
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
