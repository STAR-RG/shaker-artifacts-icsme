#!/bin/bash

#Change here if you want the default emulator to be API 28 or 23
# DEFAULT_EMULATOR="EmuAPI23"
DEFAULT_EMULATOR="EmuAPI28"

if ! type adb > /dev/null; then
    echo "Setting environment variables for adb and emulator"
    source ./setvars.sh
fi

adb start-server

if [ $# -eq 0 ]; then
    emulator -avd $DEFAULT_EMULATOR -no-accel -no-boot-anim & 
else
    if [ $# -eq 1 ]; then
        emulator -avd $1 -no-accel -no-boot-anim & 
    else
        if [ $# -eq 2 ]; then
            emulator -avd $1 -no-accel -no-boot-anim -no-window & 
        fi
    fi
fi