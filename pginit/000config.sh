#!/bin/sh


cat <<EOT >> ${PGDATA}/postgresql.conf
shared_preload_libraries='pg_cron'
cron.database_name='postgres'
EOT

# Required to load pg_cron
pg_ctl restart