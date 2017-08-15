Alluxio
=======

http://www.alluxio.org/

In-memory filesystem, formerly Tachyon (older versions are found under harisekhon/tachyon and the tachyon directory adjacent in this repo)

Starts one master and one worker and then tails the logs, maps the master and worker ports 19000 and 30000.

```
docker-compose up
```

or without `docker-compose`

```
make run
```
