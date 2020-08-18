#!/bin/bash

if [ $# -eq 0 ]; then
    ./runemulator.sh d no-gui 
else
    if [ $# -eq 1 ]; then
        ./runemulator.sh $1 no-gui & 
    fi
fi