# Minidlna Docker Image

* [![](https://badge.imagelayers.io/envygeeks/minidlna:latest.svg)][latest] `latest`
[latest]:   https://imagelayers.io?images=envygeeks/minidlna:latest

```
docker run --volume=/media/user/uuid/videos:/srv/minidlna/videos \
  --net=host -dit envygeeks/minidlna
```
