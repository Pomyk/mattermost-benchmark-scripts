#!/bin/sh

# script to generate some sample data and insert it into database

set -euf

. ./config.sh

mkdir -p ./data
mattermost sampledata -s 1 -w 8 -u 10 -t 5 --channels-per-team 5 --channel-memberships 3 --posts-per-channel 100 --posts-per-direct-channel 10 --posts-per-group-channel 10 --group-channels 1 -b ./data/1.json
mattermost sampledata -s 2 -w 8 -u 50 -t 10 --channels-per-team 5 --channel-memberships 3 --posts-per-channel 200 --posts-per-direct-channel 20 --posts-per-group-channel 20 --group-channels 2 -b ./data/2.json
mattermost sampledata -s 3 -w 8 -u 500 -t 20 --channels-per-team 10 --channel-memberships 8 --posts-per-channel 500 --posts-per-direct-channel 20 --posts-per-group-channel 20 --group-channels 3 -b ./data/3.json

# users
grep -Eo '"username":"[^"]{10,20}"' ./data/1.json | head -n 1 > ./data/users.txt
grep -Eo '"username":"[^"]{10,20}"' ./data/2.json | head -n 1 >> ./data/users.txt
grep -Eo '"username":"[^"]{10,20}"' ./data/3.json | head -n 1 >> ./data/users.txt

# teams
grep '"type":"team"' ./data/1.json | grep -Eo '"name":"[^"]{1,20}"' | head -n 1 > ./data/teams.txt
grep '"type":"team"' ./data/2.json | grep -Eo '"name":"[^"]{1,20}"' | head -n 1 >> ./data/teams.txt
grep '"type":"team"' ./data/3.json | grep -Eo '"name":"[^"]{1,20}"' | head -n 1 >> ./data/teams.txt

# channels
grep '"type":"channel"' ./data/1.json | grep -Eo '"name":"[^"]{1,20}"' | head -n 1 > ./data/channels.txt
grep '"type":"channel"' ./data/2.json | grep -Eo '"name":"[^"]{1,20}"' | head -n 1 >> ./data/channels.txt
grep '"type":"channel"' ./data/3.json | grep -Eo '"name":"[^"]{1,20}"' | head -n 1 >> ./data/channels.txt

mv ./data/1.json ./data/dump.json
grep -v '{"type":"version","version":1}' ./data/2.json >> ./data/dump.json
grep -v '{"type":"version","version":1}' ./data/3.json >> ./data/dump.json

rm ./data/2.json
rm ./data/3.json

. ./truncate.sh
# insert into first database in mysql
$MYSQL_COMMAND ${BENCHMARK_DATABASES%% *} -e "$MATTERMOST_TRUNCATE_TABLES_SQL"
mattermost import bulk --apply --workers 4 -c ./config.json ./data/dump.json

