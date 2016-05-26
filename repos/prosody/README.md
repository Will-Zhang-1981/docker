***Repository:*** https://github.com/envygeeks/docker/tree/master/repos/prosody

# Prosody Docker Image
## Environment variables

* `HOSTNAME`
* `ENABLE_SSL`

## Running

```sh
docker run --name=prosody --env=HOSTNAME=ext.host.name --env=ENABLE_SSL=true \
  --volume=/var/ssl:/var/ssl:ro -dit envygeeks/prosody
```
