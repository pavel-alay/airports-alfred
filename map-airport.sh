#!/bin/bash

code=$1

ZOOM="16"
BASEMAP="satellite"

coordiantes=$(./locate-airport.sh $code)
if ! [ -z $coordiantes ]; then
    url="https://www.google.com/maps/@?api=1&map_action=map&center=${coordiantes}&zoom=${ZOOM}&basemap=${BASEMAP}"
    echo "$url"
    open "$url"
else
    echo "Cannot find $code"
fi
