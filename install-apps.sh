#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
APK_DIR=$DIR/apk

if ! type adb > /dev/null; then
    echo "Setting environment variables for adb and emulator"
    source ./setvars.sh
fi

APKS=$APK_DIR/*.apk
for apk in $APKS
do
  adb install $APK_DIR/$apk
done