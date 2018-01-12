#!/bin/sh

PROJECT=$1
PROJECT_B=
PROJECT_P=
DATE=$(date +%F-%H-%M-%S)
if test -n "$PROJECT"
then
    PROJECT_B="-$PROJECT"
    PROJECT_P="-p $PROJECT"
fi
CONTAINER_NAME=qb-database
/usr/local/bin/docker-compose $PROJECT_P exec -T "$CONTAINER_NAME" \
    bash -c "mysqldump -u\"\$MYSQL_USER\" -p\"\$MYSQL_PASSWORD\" \"\$MYSQL_DATABASE\" --dump-date --single-transaction --extended-insert > \"\$MYSQL_BACKUP_DIR/\$MYSQL_DATABASE$PROJECT_B-$DATE.sql\""
