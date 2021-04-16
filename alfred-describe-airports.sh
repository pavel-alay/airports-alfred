#!/bin/bash -e

code=$1
LIMIT=16

if [ -z "$code" ]; then
    code="A"
fi    

query="
SELECT json_object('items',
                   json_group_array(
                       json_object(
                           'uid', code,
                           'arg', code,
                           'title', code || ': ' || name || ', ' || country,
                           'subtitle', continent || ', ' || country || ', ' || region || ', ' || municipality)
                     )) AS json_result
FROM (SELECT a.iata_code                             AS code,
             a.name                                  AS name,
             con.name                                AS continent,
             c.name                                  AS country,
             replace(r.name, '(unassigned)', c.name) AS region,
             a.municipality                          AS municipality
      FROM airports a
             INNER JOIN countries c ON a.iso_country = c.code
             INNER JOIN regions r ON a.iso_region = r.code
             INNER JOIN continents con on a.continent = con.code
      WHERE a.iata_code like '$code' || '%' ORDER BY a.iata_code LIMIT $LIMIT);
"

sqlite3 airports.db "$query"
