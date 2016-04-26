Hari Sekhon Docker
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

### Full Inventory:

##### Official Technologies:

- Alluxio
- Apache Drill
- Cassandra (with [nagios-plugins](https://github.com/harisekhon/nagios-plugins))
- Consul
- H2O by 0xdata
- HBase
- Kafka
- Mesos
- Riak
- Riak (with [nagios-plugins](https://github.com/harisekhon/nagios-plugins))
- Serf
- Spark
- Tachyon
- ZooKeeper

##### My GitHub Repos (with all libs + deps pre-built):

- [Advanced Nagios Plugins Collection](https://github.com/harisekhon/nagios-plugins) - nagios plugins for all Hadoop distributions and every major NoSQL technology - Hadoop, Redis, Elasticsearch, Solr, HBase, Cassandra & DataStax OpsCenter, MongoDB, MySQL, Kafka, Riak, Memcached, Couchbase, Mesos, Spark, Neo4j, Datameer, H2O, WanDisco, Yarn, HDFS, Impala, Apache Drill, ZooKeeper, Cloudera, Hortonworks, MapR, IBM BigInsights, Infrastructure - Linux, DNS, Whois, SSL Certs, NoSQL APIs etc
- [Perl Tools](https://github.com/harisekhon/tools) - Hadoop, Hive, Solr, Linux, SQL, Ambari, Datameer, Web and various Linux CLI Tools
- [Python Tools](https://github.com/harisekhon/pytools) - Hadoop, Spark, Pig, Ambari Blueprints, AWS CloudFormation, Linux, Data Converters & Validators (Avro/Parquet/JSON/CSV/XML/YAML), Elasticsearch, Solr, IPython
- [Spotify Tools](https://github.com/harisekhon/spotify-tools) - Backup & Play Automation: Spotify Lookup - converts Spotify URIs to 'Artist - Track' form by querying the Spotify Metadata API. Spotify Cmd - command line control of Spotify on Mac via AppleScript

- CentOS + all Github repos pre-built
- Debian + all Github repos pre-built
- Ubuntu + all Github repos pre-built

##### Base Images:

- CentOS latest (Dev) with Java JDK, Perl, Python, Ruby, GCC, Maven, SBT, Make, EPEL etc.
- Debian latest (Dev) with Java JDK, Perl, Python, Ruby, GCC, Maven, SBT, Make etc.
- Ubuntu latest (Dev) with Java JDK, Perl, Python, Ruby, GCC, Maven, SBT, Make etc.

- CentOS latest combinations of Java OpenJRE 7/8 and Scala 2.10/2.11
- Debian latest with Java OpenJRE 7
- Ubuntu 14.04 with Java OpenJRE 7

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
