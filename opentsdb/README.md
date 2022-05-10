# OpenTSDB

Open Source Time Series DB

http://opentsdb.net

Running it will by default look for HBase via a ZooKeeper ensembled at the address ```zookeeper``` which should be linked in Docker or Kubernetes

Recommended to run the docker compose to launch a cluster including the HBase and ZooKeeper dependencies

```
cd opentsdb

docker-compose up
```

If you want to do a simple `docker run` on a self contained OpenTSDB with embedded HBase and all dependencies running in one container I recommend seeing Peter Grace's OpenTSDB docker image which is better suited to simple development:

https://hub.docker.com/r/petergrace/opentsdb-docker

https://github.com/PeterGrace/opentsdb-docker

```
docker run -dp 4242:4242 petergrace/opentsdb-docker
```

For a full example of using this along with agents like TCollector, Telegraf and Collectd and see the Advanced Nagios Plugins Collection's [tests/docker/opentsdb-docker-compose.yml](https://github.com/HariSekhon/Nagios-Plugins/blob/master/tests/docker/opentsdb-docker-compose.yml)

Related Docker images can be found for many Open Source, Big Data and NoSQL technologies on [my DockerHub profile](https://hub.docker.com/r/harisekhon). The source for them all can be found in the [master Dockerfiles GitHub repo](https://github.com/HariSekhon/Dockerfiles/).
