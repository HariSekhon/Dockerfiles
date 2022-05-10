# OpenTSDB's TCollector

[![DockerHub Tcollector](https://img.shields.io/badge/DockerHub-harisekhon%2Ftcollector-blue)](https://hub.docker.com/repository/docker/harisekhon/tcollector)

Metrics collection agent for OpenTSDB:

http://opentsdb.net/docs/build/html/user_guide/utilities/tcollector.html

https://github.com/OpenTSDB/tcollector/

Running it will by default look for a host called ```opentsdb``` and begin sending metrics to it.

```
docker run -ti harisekhon/tcollector
```

For a full example of using this along with OpenTSDB see the Advanced Nagios Plugins Collection's [tests/docker/opentsdb-docker-compose.yml](https://github.com/HariSekhon/Nagios-Plugins/blob/master/tests/docker/opentsdb-docker-compose.yml)

Related Docker images can be found for many Open Source, Big Data and NoSQL technologies on [my DockerHub profile](https://hub.docker.com/r/harisekhon). The source for them all can be found in the [master Dockerfiles GitHub repo](https://github.com/HariSekhon/Dockerfiles/).
