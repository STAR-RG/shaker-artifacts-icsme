#!/bin/bash

base=./reruns/$3/$1
echo $base
mkdir -p $base

SECONDS=0
file=$base/out.$2.txt


adb shell settings put global transition_animation_scale 0
adb shell settings put global window_animation_scale 0
adb shell settings put global animator_duration_scale 0
sleep 5


./tests.sh >> $file

echo $SECONDS >> $base/time.txt

adb shell settings put global transition_animation_scale 0
adb shell settings put global window_animation_scale 0
adb shell settings put global animator_duration_scale 0

sleep 5