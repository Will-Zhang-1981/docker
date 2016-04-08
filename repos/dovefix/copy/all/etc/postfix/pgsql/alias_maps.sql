table=aliases
dbname=__PG_DATABASE__
hosts=__PG_HOSTNAME__
password=__PG_PASSWORD__
user=__PG_USERNAME__

query = SELECT destination FROM aliases WHERE lookup = '%s' AND active = true;
