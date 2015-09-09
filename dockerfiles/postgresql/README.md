# PostgreSQL Docker Image

The EnvyGeeks PostgreSQL docker image is a simple docker image that assumes
you want to get shit done rather than fight with horse shit, and it doesn't make
an ass of itself by assuming you don't know how to work PostgreSQL.

## Running

```shell
docker run --name postgresql \
  -v /srv/docker/volumes/postgresql/srv/postgresql:/srv/postgresql \
  -dit envygeeks/postgresql
```

When you first boot it, it will setup PostgreSQL and everything the way that
Debian does without need for your intervention, then once it's booted you can
start doing the real work.

## Creating Databases/Users

You create all that the same way you do on your own system. With `createdb`
and `createuser --interactive`, the reason I do it this way is because I don't
make the assumption you want one PostgreSQL per Docker instance, that and
that's bad for memory and bad for development.  We scale our PostgreSQL
and even use Docker to create snapshots.

```shell
docker exec -it postgresql sudo -u postgres createdb --owner=user db
docker exec -it postgresql sudo -u postgres createuser --interactive user
```

## Securing PostgreSQL

By default this image has `0.0.0.0 md5` which is pretty insecure, I recommend
you `docker cp` `/etc/postgresql/pg_hba.conf` and grant per db, per user perm
but if you don't want to do that I understand.
