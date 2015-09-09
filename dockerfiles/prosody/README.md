# Prosody Docker Image

The Prosody Docker image has Prosody and is simple.  It supports lua-event,
postgresql (for user persist) and SSL (by default.)

## Environment variables

* `HOSTNAME`
* `ENABLE_SSL`

## Running

```sh
docker run --name=prosody --env=HOSTNAME=ext.host.name --env=ENABLE_SSL=true \
  --volume=/var/ssl:/var/ssl:ro -dit envygeeks/prosody
```
