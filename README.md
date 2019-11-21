# Scripts to automate benchmarking of mattermost databases

Scripts to generate sample data and insert it to MySQL/PostgreSQL databases. It allows to have data with identical IDs in different databases.

## Contents

 * config.sh - configuration of database names and commands to run mysql/postgres cli
 * mkdata.sh - creates sample data and inserts it to first mysql database
 * dump.sh - dumps data (without table definitions) from mysql database and modifies it to be PostgreSQL compatibile
 * import.sh - imports dumped data to all databases
 * config.json - mattermost config file for use with sampledata/import commands (should be configured to first MySQL database in config.sh)

## Requirements

 * mattermost command in path
 * tables must be already created

## How to use

Edit database information in config.sh and config.json. Optionally edit mkdata.sh script. Run:
```bash
./mkdata.sh
./dump.sh
./import.sh
```
to populate databases. Sample IDs will be in txt files in data/ directory.

## TODO:
 * generation of benchmark testcase data
 * script to run benchmarks
