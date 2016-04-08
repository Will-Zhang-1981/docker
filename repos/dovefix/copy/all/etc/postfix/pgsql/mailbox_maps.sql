table=users
dbname=__PG_DATABASE__
hosts=__PG_HOSTNAME__
password=__PG_PASSWORD__
user=__PG_USERNAME__

query = SELECT username FROM users WHERE username = '%s' AND active = true;
