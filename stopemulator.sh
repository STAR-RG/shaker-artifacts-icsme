#!/bin/bash

if ! type adb > /dev/null; then
    echo "Setting environment variables for adb and emulator"
    source ./setvars.sh
fi

adb emu kill