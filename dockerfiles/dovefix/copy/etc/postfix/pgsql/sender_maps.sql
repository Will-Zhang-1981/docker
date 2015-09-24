table=delgates
dbname=__PG_DATABASE__
hosts=__PG_HOSTNAME__
password=__PG_PASSWORD__
user=__PG_USERNAME__

query = SELECT username FROM delegates WHERE sendas = '%s';
