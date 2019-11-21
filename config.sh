#!/bin/bash

# database names
BENCHMARK_DATABASES="mattermost_test mattermost_test_new"

MYSQL_COMMAND="mysql -A -B -s -u mmuser -h 127.0.0.1"
MYSQLDUMP_COMMAND="mysqldump -u mmuser -h 127.0.0.1"

POSTGRESQL_COMMAND="psql -q -h localhost -p 5432 -U mmuser"
