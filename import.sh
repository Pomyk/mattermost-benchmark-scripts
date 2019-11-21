#!/bin/sh

# imports data into databases

set -euf

. ./config.sh
. ./truncate.sh

for DB in $BENCHMARK_DATABASES; do
    if [ -n "$MYSQL_COMMAND" ]; then
        $MYSQL_COMMAND $DB -e "$MATTERMOST_TRUNCATE_TABLES_SQL"
        $MYSQL_COMMAND $DB < ./data/dump.sql
    fi
    if [ -n "$POSTGRESQL_COMMAND" ]; then
        $POSTGRESQL_COMMAND $DB -c "$MATTERMOST_TRUNCATE_TABLES_SQL"
        $POSTGRESQL_COMMAND $DB < ./data/dump.sql
    fi
done
