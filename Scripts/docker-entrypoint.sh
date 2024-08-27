#!/bin/sh
set -e

if [ -z "$POSTGRES_USER" ]; then
  echo "ERROR: POSTGRES_USER is not set."
  exit 1
fi

if [ -z "$POSTGRES_PASSWORD" ]; then
  echo "ERROR: POSTGRES_PASSWORD is not set."
  exit 1
fi

# If PGDATA directory is empty, initialize the database
if [ -z "$(ls -A "$PGDATA")" ]; then
    su-exec postgres initdb

    # Set the password for the default user
    su-exec postgres pg_ctl -D "$PGDATA" start

    # Create user and database
    su-exec postgres psql --command "CREATE USER $POSTGRES_USER WITH SUPERUSER PASSWORD '$POSTGRES_PASSWORD';"
    su-exec postgres createdb -O "$POSTGRES_USER" "$POSTGRES_DB"

    # Stop the PostgreSQL server
    su-exec postgres pg_ctl -D "$PGDATA" stop
fi

echo "listen_addresses = '*'" >> "$PGDATA/postgresql.conf"
echo "host    all             $POSTGRES_USER    0.0.0.0/0            md5" >> "$PGDATA/pg_hba.conf"

# Start PostgreSQL server
exec su-exec postgres "$@"
