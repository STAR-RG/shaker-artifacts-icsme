#!/bin/bash

if ! type adb > /dev/null; then
    source ./setvars.sh
fi

adb start-server

if [ $# -eq 0 ] then
    emulator -avd d -no-accel -no-boot-anim & 
else
    if [ $# -eq 1 ] then
        emulator -avd $1 -no-accel -no-boot-anim & 
    else
        if [ $# -eq 2 ] then
            emulator -avd $1 -no-accel -no-boot-anim -no-window & 
        fi
    fi
fi
