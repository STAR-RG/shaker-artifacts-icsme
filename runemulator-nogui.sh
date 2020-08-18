#!/bin/bash

if ! type adb > /dev/null; then
    source ./setvars.sh
fi

AVD_NAME=$1

adb start-server
emulator -avd $AVD_NAME -no-accel -no-boot-anim -no-window & 