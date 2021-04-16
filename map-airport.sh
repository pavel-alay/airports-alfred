#!/bin/bash

code=$1

ZOOM="16"
BASEMAP="satelite"

coordiantes=$(./locate-airport.sh $code)
echo $coordiantes
if ! [ -z $coordiantes ]; then
    url="https://www.google.com/maps/@?api=1&map_action=map&center=${coordiantes}&zoom=${ZOOM}&basemap=${BASEMAP}"
    open "$url"
else
    echo "Cannot find $code"
fi
