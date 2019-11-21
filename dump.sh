#!/bin/sh

# dumps data (without table definitions) from MySQL database
# and modifies it to be PostgreSQL compatibile

set -euf

. ./config.sh

$MYSQLDUMP_COMMAND --skip-quote-names --skip-add-locks --skip-disable-keys --no-create-info ${BENCHMARK_DATABASES%% *} > ./data/dump.sql

# fix boolean columns, executed twice to handle cases like 0,0,0
sed -E -i  "s/,([01])([,)])/,'\1'\2/g" ./data/dump.sql
sed -E -i  "s/,([01])([,)])/,'\1'\2/g" ./data/dump.sql
echo $AXA
