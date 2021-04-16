#!/bin/bash

code=$1

if [ -z "$code" ]; then
    code="A"
fi

query="
SELECT latitude_deg || ',' || longitude_deg
FROM airports
WHERE iata_code LIKE '$code' || '%' LIMIT 1;
"

sqlite3 airports.db "$query"
