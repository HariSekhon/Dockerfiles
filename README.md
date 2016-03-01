Hari Sekhon Docker Images
=========================

#### Docker Images containing:

* [My GitHub repos](https://github.com/HariSekhon) with all dependencies pre-built
* NoSQL, RDBMS, OS images used for development and functional test suites

These images are all available pre-built on [My DockerHub](https://hub.docker.com/u/harisekhon/).

##### Ready to run Docker images #####

To use the pre-built Docker images, search for all available images:

```docker search harisekhon```

then select one and pull / run it as usual:

```docker run -ti harisekhon/nagios-plugins```

##### Build from Dockerfiles #####

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
