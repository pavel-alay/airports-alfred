#!/bin/bash -e

PATH_DB="../airports.db"

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
