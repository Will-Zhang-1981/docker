# Ghost Docker Image

* [![](https://badge.imagelayers.io/envygeeks/ghost:latest.svg)][latest] `latest`
[latest]: https://imagelayers.io?images=envygeeks/ghost:latest

## Usage

```
docker run --rm -p 4000:4000 \
  -dit envygeeks/ghost
```

## Environment variables

* `$URL` - Full URL - Overrides `$PORT`, `$DOMAIN`, `$USE_PROXY` and `$FORCE_SSL`
* `$FORCE_SSL` Default: false.
* `$USE_PROXY` Default: false.
* `$PORT` - Default: `4000`.
* `$DOMAIN` - Default: `localhost`.
* `$LISTEN_ADDRESS` - Default: `0.0.0.0`.
* `$MAIL_SERVICE` - Mandrill, MailGun, SMTP.
* `$MAIL_USER` - Username.
* `$MAIL_PASS` - API Key or Password.
* `$DATABASE_TYPE` - PostgreSQL, MySQL - Default: `pg`
* `$DATABASE_HOST` - DB hostname - Default: `postgresql`.
* `$DATABASE_PORT` - DB port - Default: `5432`.
* `$DATABASE_USER` - DB user - Default: `ghost`.
* `$DATABASE` - The DB - Default: `ghost`.
* `$DATABASE_PASS` - DB pass.

## Database / Storage

By default this image will use SQLite and store the database in `/srv/ghost` for you, so that you can mount a data container or preferably a local folder and persist the data, if you wish to use an external database use environment variables to set the data for the configuration.
