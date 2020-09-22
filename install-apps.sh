#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
APK_DIR=$DIR/ICSME2020/apk

if ! type adb > /dev/null; then
    echo "Setting environment variables for adb and emulator"
    source ./setvars.sh
fi

APKS=$APK_DIR/*.apk
for apk in $APKS
do
  APP_NAME=$(basename $apk)
  echo "Installing $APP_NAME"
  adb install -t $apk
done
