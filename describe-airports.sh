#!/bin/bash -e

code=$1
LIMIT=16

if [ -z "$code" ]; then
    code="A"
fi    


query="
SELECT a.iata_code || ': ' || a.name || ', '  || con.name || ', ' ||
        c.name || ', ' || replace(r.name, '(unassigned)', c.name) || ', ' || a.municipality as description
      from airports a
             INNER JOIN countries c on a.iso_country = c.code
             INNER JOIN regions r on a.iso_region = r.code
             INNER JOIN continents con on a.continent = con.code
      where a.iata_code like '$code' || '%'  LIMIT $LIMIT;
"

sqlite3 airports.db "$query"
