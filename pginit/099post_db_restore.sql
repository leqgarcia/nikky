
\set pg_pwd `echo "$POSTGRES_PASSWORD"`


ALTER USER nikky WITH PASSWORD :'pg_pwd';
