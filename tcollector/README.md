OpenTSDB's TCollector
=====================

Metrics collection agent for OpenTSDB:

http://opentsdb.net/docs/build/html/user_guide/utilities/tcollector.html

https://github.com/OpenTSDB/tcollector/

```
docker run -ti harisekhon/tcollector
```

This will by default look for a host called ```opentsdb``` and begin sending metrics to it.

For a full example of using this along with OpenTSDB see the Advanced Nagios Plugins Collection's [test/docker/opentsdb-docker-compose.yml](https://github.com/HariSekhon/nagios-plugins/blob/master/tests/docker/opentsdb-docker-compose.yml)
