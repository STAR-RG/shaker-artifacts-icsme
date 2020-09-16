#!/bin/bash

#Change here if you want the default emulator to be API 28 or 23
# DEFAULT_EMULATOR="EmuAPI23"
DEFAULT_EMULATOR="EmuAPI28"

if [ $# -eq 0 ]; then
    ./runemulator.sh $DEFAULT_EMULATOR no-gui 
else
    if [ $# -eq 1 ]; then
        ./runemulator.sh $1 no-gui & 
    fi
fi