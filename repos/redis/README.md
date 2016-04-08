***Repository:*** https://github.com/envygeeks/docker/tree/master/repos/redis
# Redis Docker Image

A simple Redis Docker image that does nothing special but provide the latest version of Redis that I know about and support (that has no security problems. Not that Redis has any security problems by nature.)

## Running

```shell
docker run --name redis -P \
  -dit envygeeks/redis
```
