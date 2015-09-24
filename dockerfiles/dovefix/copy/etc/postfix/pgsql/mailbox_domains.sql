table=domains
dbname=__PG_DATABASE__
hosts=__PG_HOSTNAME__
password=__PG_PASSWORD__
user=__PG_USERNAME__

query = SELECT domain FROM domains WHERE domain = '%s' AND active = true AND backup = false;
