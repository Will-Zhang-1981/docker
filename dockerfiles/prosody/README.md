# Prosody Docker Image

* [![](https://badge.imagelayers.io/envygeeks/prosody:latest.svg)][latest] `latest`
[latest]:   https://imagelayers.io?images=envygeeks/prosody:latest

## Environment variables

* `HOSTNAME`
* `ENABLE_SSL`

## Running

```sh
docker run --name=prosody --env=HOSTNAME=ext.host.name --env=ENABLE_SSL=true \
  --volume=/var/ssl:/var/ssl:ro -dit envygeeks/prosody
```
