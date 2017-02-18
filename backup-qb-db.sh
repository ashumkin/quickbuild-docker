#!/bin/sh

CONTAINER_NAME=$(/usr/local/bin/docker-compose ps | grep qb-database | cut -d' ' -f1)
docker exec -t "$CONTAINER_NAME" \
    bash -c 'mysqldump -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" --dump-date --single-transaction --extended-insert > "$MYSQL_BACKUP_DIR/$MYSQL_DATABASE.sql"'
