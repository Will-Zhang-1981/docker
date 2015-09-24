# Dovefix Docker Image

* [![](https://badge.imagelayers.io/envygeeks/dovefix:latest.svg)][latest] `latest`
[latest]:   https://imagelayers.io?images=envygeeks/dovefix:latest

The Dovefix Docker image has postfix (w/ postscreen), dovecot, opendkim, and
postgrey.  By default it assumes you aren't an ass and you want to use SSL so if
you do not volume an SSL folder with an SSL named after your hostname it will
require you to set `DISABLE_SSL=true` manually using `--env`.

## Environment Variables

* $PG_HOSTNAME  *required*
* $PG_PASSWORD  *required*
* $PG_USERNAME  default: *dovefix*
* $PG_DATABASE  default: *dovefix*
* $DISABLE_SSL  default: *false*
* $HOSTNAME     *required*

## SSL Certificates

You should place and volume `/var/ssl/$HOSTNAME.crt` and
`/var/ssl/$HOSTNAME.key`

## Running

This image requires: `envygeeks/postgresql` or equiv.

```shell
docker run --name dovefix \
  --link postgresql:postgresql \
  -e PGUSERNAME=dovefix \
  -e MAILDOMAIN=ext.host.name \
  -e PGHOSTNAME=postgresql \
  -e PGPASSWORD=password \
  -e PGDATABASE=dovefix \
  -v /var/ssl:/var/ssl \
  -dit \
    envygeeks/dovefix
```

### Create DB Tables

By default whenever you boot this image it will try to creat the database tables
and when it can't it will still continue on (just incase you already created
them.) There is a timeout of 12 seconds before it will exit and continue on so
that you can keep on booting, the timeout exists mostly because `psql` does not
time itself out, so we must ensure that you do not lock up the image with a bad
hostname.

## Data Persistence

`/var/spam` and `/var/mail` are volumes and they hold most if not all of the
data for your mail instance, you should either store those on your srv or you
can create a data container, if you wish to store them on your server there is a
user script in the `script/` folder that will create all of the static users for
this and all the other images so you can prevent user permission problems.
You'll probably need that even for a data container because everything is ran as
user per normal unix policy.
