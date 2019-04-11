#!/bin/bash

export PATH="$PATH:/usr/lib/postgresql/9.6/bin"

[ ! -s "$PGDATA/PG_VERSION" ] && \
  echo "Data folder is not initialized, will init a brand new db" && \
  initdb -E UTF8 && rm $PGDATA/postgresql.conf && rm $PGDATA/pg_ident.conf

exec postgres -D /etc/postgresql
#exec $@
