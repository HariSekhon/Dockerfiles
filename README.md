Hari Sekhon Docker [![DockerHub](https://img.shields.io/badge/docker-available-blue.svg)](https://hub.docker.com/u/harisekhon/)
=========================

Docker Images containing hundreds of my published tools and the supporting technologies to run full functional test suites.

### Contains:

* [My GitHub repos](https://github.com/HariSekhon) with all dependencies pre-built
* NoSQL, RDBMS & OS images used for development and functional test suites

These images are all available pre-built on [My DockerHub](https://hub.docker.com/u/harisekhon/).

### Ready to run Docker images

To see all my available Docker images:

```docker search harisekhon```

then select one and pull / run it as usual:

```docker run -ti harisekhon/nagios-plugins```

There are lots of tagged versions - docker cli doesn't support showing tags yet ([docker ticket](https://github.com/docker/docker/issues/17238)) so to see DockerHub tags in general you use the ```dockerhub_show_tags.py``` tool from my [PyTools repo](https://github.com/harisekhon/pytools), a docker image of which is also supplied:

eg. to see an organized list of all tags for the official CentOS & Ubuntu repos dynamically using the DockerHub API:
```
docker run harisekhon/pytools dockerhub_show_tags.py centos ubuntu
```

### Full Inventory:

##### Official Technologies:

- Alluxio
- Apache Drill (embedded, opens Drill shell)
- Cassandra (with [nagios-plugins](https://github.com/harisekhon/nagios-plugins), opens CQL shell)
- Consul
- H2O by 0xdata
- Hadoop (HDFS + Yarn, pseudo-distributed)
- HBase (pseudo-distributed, opens HBase shell)
- Kafka
- Mesos
- Riak
- Riak (with [nagios-plugins](https://github.com/harisekhon/nagios-plugins))
- Serf
- Solr
- SolrCloud
- Spark (opens Spark shell)
- Tachyon
- ZooKeeper (opens ZK shell)

##### My GitHub Repos (with all libs + deps pre-built):

- [Advanced Nagios Plugins Collection](https://github.com/harisekhon/nagios-plugins) - 250+ nagios plugins for every Hadoop distribution and every major NoSQL technology - Hadoop, Redis, Elasticsearch, Solr, HBase, Cassandra & DataStax OpsCenter, MongoDB, MySQL, Kafka, Riak, Memcached, Couchbase, Mesos, Spark, Neo4j, Datameer, H2O, WanDisco, Yarn, HDFS, Impala, Apache Drill, ZooKeeper, Cloudera, Hortonworks, MapR, IBM BigInsights, Infrastructure - Linux, DNS, Whois, SSL Certs, NoSQL APIs etc
- [Perl Tools](https://github.com/harisekhon/tools) - 25+ Hadoop, Hive, Solr, Linux, SQL, Ambari, Datameer, Web and various Linux CLI Tools
- [Python Tools](https://github.com/harisekhon/pytools) - 25+ Hadoop, Spark, Pig, Ambari Blueprints, AWS CloudFormation, Linux, Data Converters & Validators (Avro/Parquet/JSON/CSV/XML/YAML), Elasticsearch, Solr, IPython - CLI tools
- [Spotify Tools](https://github.com/harisekhon/spotify-tools) - Backup & Play Automation: Spotify Lookup - converts Spotify URIs to 'Artist - Track' form by querying the Spotify Metadata API. Spotify Cmd - command line control of Spotify on Mac via AppleScript for automation, auto timed track flick through etc.

- CentOS + all Github repos pre-built
- Debian + all Github repos pre-built
- Ubuntu + all Github repos pre-built

##### Base Images:

- CentOS latest (Dev) with Java JDK, Perl, Python, Ruby, Groovy, GCC, Maven, SBT, Gradle, Make, EPEL etc.
- Debian latest (Dev) with Java JDK, Perl, Python, Ruby, Groovy, GCC, Maven, SBT, Gradle, Make etc.
- Ubuntu latest (Dev) with Java JDK, Perl, Python, Ruby, Groovy, GCC, Maven, SBT, Gradle, Make etc.

###### Base Images + Java / Scala:

All builds use OpenJDK for dev / OpenJRE for run. See this article below for why it might be illegal to bundle Oracle Java (and why no Linux distributions do this either):

https://www.javacodegeeks.com/2016/03/running-java-docker-youre-breaking-law.html

- CentOS latest combinations of Java 7/8 (OpenJRE) and Scala 2.10/2.11
- Debian latest with Java 7 (OpenJRE)
- Ubuntu 14.04 with Java 7, Ubuntu latest with Java 8, 9 (OpenJRE)

### To Build from Dockerfile + source yourself

```
git clone https://github/harisekhon/Dockerfiles

cd Dockerfiles
```

To build all Docker images:
```
make
```

To build a specific Docker image, enter it's directory and run make:

```
cd nagios-plugins

make
```

### Support

Please raise tickets for issues and improvements at https://github.com/harisekhon/dockerfiles/issues
