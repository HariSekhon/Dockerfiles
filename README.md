Hari Sekhon Dockerfiles
=======================

#### Docker Images of my GitHub repos with all dependencies pre-built, as well as functional test suite images for 3rd party and NoSQL systems ####

These images are all available pre-built on [my DockerHub](https://hub.docker.com/u/harisekhon/).

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
