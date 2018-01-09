#!/bin/sh

PROJECT=$1
PROJECT_B=
PROJECT_P=
if test -n "$PROJECT"
then
    PROJECT_B="-$PROJECT"
    PROJECT_P="-p $PROJECT"
fi
CONTAINER_NAME=qb-database
/usr/local/bin/docker-compose $PROJECT_P exec -T "$CONTAINER_NAME" \
    bash -c "mysql -u\"\$MYSQL_USER\" -p\"\$MYSQL_PASSWORD\" \"\$MYSQL_DATABASE\" < \"\$MYSQL_BACKUP_DIR/\$MYSQL_DATABASE$PROJECT_B.sql\""
