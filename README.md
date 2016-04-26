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

##### My GitHub Repos:

- Nagios Plugins ([Advanced Nagios Plugins Collection](https://github.com/harisekhon/nagios-plugins) pre-built)
- Perl CLI Tools ([Tools](https://github.com/harisekhon/tools) pre-built)
- PyTools CLI tools ([PyTools](https://github.com/harisekhon/pytools) pre-built)

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

To build images from source Dockerfiles, either

```
cd nagios-plugins

make
```

or to build all images locally, run ```make``` at the top level.
