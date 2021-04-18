#!/bin/bash -ex

PATH_DB="../airports.db"

curl -s https://ourairports.com/data/airports.csv -o airports.csv
curl -s https://ourairports.com/data/regions.csv -o regions.csv
curl -s https://ourairports.com/data/countries.csv -o countries.csv

if test "$PATH_DB"; then
    echo "$PATH_DB already exist"
    read -r -p "Would you like to drop it?" ANSWER
    rm -f "${PATH_DB:?}"
fi

sqlite3 -csv "$PATH_DB" ".import airports.csv airports"
sqlite3 -csv "$PATH_DB" ".import countries.csv countries"
sqlite3 -csv "$PATH_DB" ".import regions.csv regions"
sqlite3 -csv "$PATH_DB" ".import continents.csv continents"

echo "Done: $PATH_DB"
