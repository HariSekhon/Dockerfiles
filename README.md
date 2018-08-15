Hadoop, Big Data, NoSQL & DevOps Docker Images
==================
[![Build Status](https://travis-ci.org/HariSekhon/Dockerfiles.svg?branch=master)](https://travis-ci.org/HariSekhon/Dockerfiles) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/de6229f2d2ba4945acde9f86f59d2c66)](https://www.codacy.com/app/harisekhon/Dockerfiles) [![GitHub stars](https://img.shields.io/github/stars/harisekhon/Dockerfiles.svg)](https://github.com/harisekhon/Dockerfiles/stargazers) [![GitHub forks](https://img.shields.io/github/forks/harisekhon/Dockerfiles.svg)](https://github.com/harisekhon/Dockerfiles/network) [![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20OS%20X-blue.svg)](https://github.com/HariSekhon/Dockerfiles#hari-sekhon-docker) [![DockerHub](https://img.shields.io/badge/docker-available-blue.svg)](https://hub.docker.com/u/harisekhon/)

##### Contains 45 DockerHub repos with 340+ tags, many different versions of standard official open source software, see [Full Inventory](https://github.com/HariSekhon/Dockerfiles#full-inventory) futher down.

These docker images are tested by hundreds of tools and also used in the full functional test suites of various other GitHub repos.

Overview - this repo contains:

* **Hadoop & Big Data** ecosystem technologies (Spark, Kafka, Presto, Drill, Nifi, ZooKeeper)
* **NoSQL** datastores (HBase, Cassandra, Riak, SolrCloud)
* OS & development images (Alpine, CentOS, Debian, Ubuntu)
* **DevOps** tech, anything cool and open source (RabbitMQ Cluster, Mesos, Consul)
* [My GitHub repos](https://github.com/HariSekhon) containing hundreds of tools related to these technologies with all dependencies pre-built

These images are all available pre-built on [My DockerHub - https://hub.docker.com/u/harisekhon/](https://hub.docker.com/u/harisekhon/).

**Quality and Testing** - this repo has entire test suites run against it from various [GitHub repositories](https://github.com/HariSekhon) to validate the docker images' functionality, branches vs tagged versions align, latest contains correct version from master branch, syntax checks covering all common build and file formats (Make/JSON/CSV/INI/XML/YAML configurations) etc.

These are reusable tests that can anybody can implement and can be found in my [DevOps Python Tools](https://github.com/HariSekhon/devops-python-tools) and [Bash-Tools](https://github.com/HariSekhon/bash-tools) repos as well as the [Advanced Nagios Plugins Collection](https://github.com/HariSekhon/nagios-plugins) which contains hundreds of technology specific API-level test programs to ensure the docker images are functioning as intended.

[Continuous Integration](https://travis-ci.org/HariSekhon/Dockerfiles) in run on this and adjacent repos that form a bi-directional validation between these docker images and several other repositories full of hundreds of programs. All of this is intended to keep the quality of this repo as high as possible.

Hari Sekhon

Big Data Contractor, United Kingdom

(ex-Cloudera, Hortonworks Consultant)

https://www.linkedin.com/in/harisekhon
###### (you're welcome to connect with me on LinkedIn)

### Ready to run Docker images

```
docker search harisekhon
docker run harisekhon/nagios-plugins
```

To see more than the 25 DockerHub repos limited by ```docker search``` ([docker issue 23055](https://github.com/docker/docker/issues/23055)) I wrote ```dockerhub_search.py``` using the DockerHub API, available in my [DevOps Python Tools github repo](https://github.com/harisekhon/devops-python-tools) and as a pre-built docker image:

```
docker run harisekhon/pytools dockerhub_search.py harisekhon
```

There are lots of tagged versions of official software in my repos to allow development testing across multiple versions, usually more versions than available from the official repos (and new version updates available on request, just [raise a GitHub issue](https://github.com/harisekhon/Dockerfiles/issues)).

DockerHub tags are not shown by ```docker search``` ([docker issue 17238](https://github.com/docker/docker/issues/17238)) so I wrote ```dockerhub_show_tags.py``` available in my [DevOps Python Tools github repo](https://github.com/harisekhon/devops-python-tools) and as a pre-built docker image - eg. to see an organized list of all CentOS tags:

```
docker run harisekhon/pytools dockerhub_show_tags.py centos
```

For service technologies like Hadoop, HBase, ZooKeeper etc for which you'll also want port mappings, each directory in the [GitHub project](https://github.com/harisekhon/dockerfiles) contains both a standard ` docker-compose ` configuration as well as a ` make run ` shortcut (which doesn't require ` docker-compose ` to be installed) - either way you don't have to remember all the command line switches and port number specifics:

```
cd zookeeper
docker-compose up
```

or for technologies with interactive shells like Spark, ZooKeeper, HBase, Drill, Cassandra where you want to be dropped in to an interactive shell, use the ` make run ` shortcut instead:

```
cd zookeeper
make run
```

which is much easier to type and remember than the equivalent bigger commands like:

```
docker run -ti -p 2181:2181 harisekhon/zookeeper
```

and avoid this for more complex services like Hadoop / HBase:

```
docker run -ti -p 2181:2181 -p 8080:8080 -p 8085:8085 -p 9090:9090 -p 9095:9095 -p 16000:16000 -p 16010:16010 -p 16201:16201 -p 16301:16301 harisekhon/hbase
```

```
docker run -ti -p 8020:8020 -p 8032:8032 -p 8088:8088 -p 9000:9000 -p 10020:10020 -p 19888:19888 -p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50075:50075 -p 50090:50090 harisekhon/hadoop
```

### Full Inventory:

##### Official Standard Open Source Technologies:

More specific information can be found in the readme page under each respective directory in the [Dockerfiles git repo](https://github.com/HariSekhon/Dockerfiles).

- [Alluxio](http://www.alluxio.org/) - distributed in-memory filesystem for cluster computing frameworks by UC Berkely's [AMPLab](https://amplab.cs.berkeley.edu/) - [readme](https://github.com/HariSekhon/Dockerfiles/blob/master/alluxio/README-alluxio.md)
- [Apache Drill](https://drill.apache.org/) - distributed SQL engine by [MapR](https://mapr.com/) (opens Drill SQL shell) - [readme](https://github.com/HariSekhon/Dockerfiles/blob/master/apache-drill/README-apache-drill.md)
- [Cassandra](http://cassandra.apache.org/) - distributed NoSQL datastore by Facebook and [DataStax](https://www.datastax.com/) (opens CQL shell, bundled with [nagios-plugins](https://github.com/harisekhon/nagios-plugins))
- [Consul](https://www.consul.io/) - distributed service discovery by [HashiCorp](https://www.hashicorp.com/)
- [H2O](https://www.h2o.ai/) - distributed machine learning framework by [0xdata](https://www.h2o.ai/)
- [Hadoop](http://hadoop.apache.org/) (HDFS + Yarn) - distributed storage and compute cluster by Yahoo, [Cloudera](https://www.cloudera.com/) and [Hortonworks](https://hortonworks.com/)
- [HBase](https://hbase.apache.org/) - distributed NoSQL datastore by Facebook (opens HBase shell) - [readme](https://github.com/HariSekhon/Dockerfiles/blob/master/hbase/README-hbase.md)
- [Jython](http://www.jython.org/) - Python on Java JVM (useful for Hadoop python utilities using Hadoop's Java API. eg. [DevOps Python Tools](https://github.com/harisekhon/devops-python-tools))
- [Kafka](https://kafka.apache.org/) - pub-sub data broker by [LinkedIn](https://www.linkedin.com) and [Confluent](https://www.confluent.io/)
- [Mesos](http://mesos.apache.org/) - datacenter resource manager by [Mesosphere](https://mesosphere.com/) (mostly obsoleted by more free Hortonworks / Hadoop Yarn resource manager)
- [Nifi](https://nifi.apache.org/) - IOT data flow engine by NSA and [Hortonworks](https://hortonworks.com/)
- [OpenTSDB TCollector](http://opentsdb.net/docs/build/html/user_guide/utilities/tcollector.html) - metrics collector - sends metrics to OpenTSDB - [readme](https://github.com/HariSekhon/Dockerfiles/blob/master/tcollector/README-tcollector.md)
- [Presto](https://prestodb.io/) - distributed SQL engine by Facebook (opens Presto SQL shell) - [readme](https://github.com/HariSekhon/Dockerfiles/blob/master/presto-dev/README-presto.md)
- [Presto (Teradata distribution)](http://www.teradata.com/products-and-services/Presto/Presto-Download) - Teradata's Presto distribution including ODBC and JDBC drivers (opens Presto SQL shell) - [readme](https://github.com/HariSekhon/Dockerfiles/blob/master/presto/README-presto.md)
- [RabbitMQ](https://www.rabbitmq.com/) Cluster - pub-sub message queue broker by [Pivotal](https://pivotal.io/) (extension of RabbitMQ official image with added plugins)
- [Riak KV](http://basho.com/products/riak-kv/) - distributed NoSQL datastore by [Basho](http://basho.com/)
- [Riak KV](http://basho.com/products/riak-kv/) (bundled with [nagios-plugins](https://github.com/harisekhon/nagios-plugins))
- [Serf](https://www.serf.io/) - decentralized cluster coordination engine by [HashiCorp](https://www.hashicorp.com/)
- [Solr](http://lucene.apache.org/solr/) - mature indexing engine built on Lucene search library
- [SolrCloud](http://lucene.apache.org/solr/) - clustered distributed indexing engine version of Solr
- [Spark](https://spark.apache.org/) - fast distributed cluster compute engine usually used on Hadoop, by UC Berkely's [AMPLab](https://amplab.cs.berkeley.edu/) and [Databricks](https://databricks.com/) (opens Spark shell)
- [Superset](http://airbnb.io/projects/superset/) - data visualization by [Airbnb](https://www.airbnb.com/)
- [Tachyon](http://www.alluxio.org/) (Alluxio < 1.0) - distributed in-memory filesystem for cluster computing frameworks by UC Berkely's [AMPLab](https://amplab.cs.berkeley.edu/)
- [ZooKeeper](https://zookeeper.apache.org/) (opens ZK shell) - distributed coordination and sychronization service by Yahoo

Repos suffixed with ```-dev``` are the official technologies + development & debugging tools + my github repos with all dependencies pre-built.

##### My GitHub Repos (with all libs + deps pre-built):

- [Advanced Nagios Plugins Collection](https://github.com/harisekhon/nagios-plugins) - 350+ nagios plugins for every Hadoop distribution and every major NoSQL technology - Hadoop, Redis, Elasticsearch, Solr, HBase, Cassandra & DataStax OpsCenter, MongoDB, MySQL, Kafka, Riak, Memcached, Couchbase, CouchDB, Mesos, Spark, Neo4j, Datameer, H2O, WanDisco, Yarn, HDFS, Impala, Apache Drill, Presto, ZooKeeper, Cloudera, Hortonworks, MapR, IBM BigInsights, Infrastructure - Linux, DNS, Whois, SSL Certs etc
  - Tags:
    - nagios-plugins:latest (centos)
    - nagios-plugins:alpine
    - nagios-plugins:centos
    - nagios-plugins:debian
    - nagios-plugins:ubuntu
- [DevOps Python Tools](https://github.com/harisekhon/devops-python-tools) - 50+ tools for Hadoop, Spark, Pig, Ambari Blueprints, AWS CloudFormation, Linux, Data Converters & Validators (Avro/Parquet/JSON/CSV/XML/YAML), Elasticsearch, Solr, IPython - CLI tools
- [DevOps Perl Tools](https://github.com/harisekhon/devops-perl-tools) - 25+ tools for Hadoop, Hive, Solr, Linux, SQL, Ambari, Datameer, Web and various Linux CLI Tools
- [Spotify Tools](https://github.com/harisekhon/spotify-tools) - Backup & Play Automation: Spotify Lookup - converts Spotify URIs to 'Artist - Track' form by querying the Spotify Metadata API. Spotify Cmd - command line control of Spotify on Mac via AppleScript for automation, auto timed track flick through etc.

- CentOS + all Github repos pre-built
- Debian + all Github repos pre-built
- Ubuntu + all Github repos pre-built
- Alpine + all Github repos pre-built

##### Base Images:

Dev images:

- CentOS latest with Java JDK, Perl, Python, Jython, Ruby, Scala, Groovy, GCC, Maven, SBT, Gradle, Make, Expect, EPEL etc.
- Debian latest with Java JDK, Perl, Python, Jython, Ruby, Scala, Groovy, GCC, Maven, SBT, Gradle, Make, Expect etc.
- Ubuntu latest with Java JDK, Perl, Python, Jython, Ruby, Scala, Groovy, GCC, Maven, SBT, Gradle, Make, Expect etc.
- Alpine latest with Java JDK, Perl, Python, Jython, Ruby, Scala, Groovy, GCC, Maven, SBT, Gradle, Make, Expect etc.

###### Base Images of Java / Scala:

All builds use OpenJDK with ```jre``` and ```jdk``` numbered tags. See this article below for why it might be illegal to bundle Oracle Java (and why no Linux distributions do this either):

https://www.javacodegeeks.com/2016/03/running-java-docker-youre-breaking-law.html

- CentOS latest combinations of Java 7/8 and Scala 2.10/2.11
- Debian latest with Java 7
- Ubuntu 14.04 with Java 7
- Ubuntu latest with Java 8, 9

### Build from Source

All images come pre-built on [DockerHub](https://hub.docker.com/u/harisekhon/) but if you want to compile from source for any reason such as developing improvements, I've made this easy to do:

```
git clone https://github.com/harisekhon/Dockerfiles

cd Dockerfiles
```

To build all Docker images, just run the ```make``` command at the top level:

```
make
```

To build a specific Docker image, enter its directory and run `make`:

```
cd nagios-plugins

make
```

You can also build a specific version by checking out the git branch for the version and running the build:

```
cd consul
git checkout consul-0.9
make
```

or build all versions of a given software project like so:

```
cd hadoop
make build-versions
```

See the top level `Makefile` as well as the `Makefile.in` which is sourced per project with any project specific overrides in the `<project_directory>/Makefile`.

### Support

Please raise tickets for issues and improvements at https://github.com/harisekhon/dockerfiles/issues
