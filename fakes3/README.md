# FakeS3

[![DockerHub FakeS3](https://img.shields.io/badge/DockerHub-harisekhon%2Ffakes3-blue)](https://hub.docker.com/repository/docker/harisekhon/fakes3)

https://github.com/jubos/fake-s3

Local lightweight Amazon S3 API server simulator. Useful for running tests without incurring AWS S3 costs.

You must supply your license key as the argument (you can get one free for personal use and small projects from https://supso.org/projects/fake-s3).

Edit the `docker-compose.yml` file to put in your license key, then run:
```
docker-compose up
```

or without `docker-compose`

```
docker run harisekhon/fakes3 <license_key>
```

Related Docker images can be found for many Open Source, Big Data and NoSQL technologies on [my DockerHub profile](https://hub.docker.com/r/harisekhon). The source for them all can be found in the [master Dockerfiles GitHub repo](https://github.com/HariSekhon/Dockerfiles/).
