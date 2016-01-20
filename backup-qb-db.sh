#!/bin/sh

CONTAINER_NAME=$(docker-compose ps | grep qb-database | cut -d' ' -f1)
docker exec "$CONTAINER_NAME" \
    bash -c 'mysqldump -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" --dump-date --single-transaction --extended-insert > "$MYSQL_BACKUP_DIR/$MYSQL_DATABASE.sql"'
#docker run -it --link "$CONTAINER_NAME":mysql --rm mariadb sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -u"$MYSQL_ENV_MYSQL_USER" -p"$MYSQL_ENV_MYSQL_PASSWORD" "$MYSQL_ENV_MYSQL_DATABASE"'
