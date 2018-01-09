#!/bin/sh

CONTAINER_NAME=qb-database
/usr/local/bin/docker-compose exec -T "$CONTAINER_NAME" \
    bash -c 'mysqldump -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" --dump-date --single-transaction --extended-insert > "$MYSQL_BACKUP_DIR/$MYSQL_DATABASE.sql"'
