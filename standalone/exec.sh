#!/bin/bash

emulator=$9

##stress
if [ $6 == 1 ]
then
  echo '>1'
  taskset -c -pa 0 $emulator > trash.txt
fi
if [ $6 == 2 ]
then
  echo '>2'
  taskset -c -pa 0,1 $emulator > trash.txt
fi
if [ $6 == 3 ]
then
  echo '>3'
  taskset -c -pa 0,1,2 $emulator > trash.txt
fi
if [ $6 == 4 ]
then
  taskset -c -pa 0,1,2,3 $emulator > trash.txt
fi

if [ $2 ]
then
  stress-ng --cpu $2 --cpu-load $3% --vm $4 --vm-bytes $5% &
  PID=$!
fi


base=./outputs/$8/$1
echo $base
mkdir -p $base
for i in $(seq $7);
do
  SECONDS=0
  file=$base/out.$i.txt


  adb shell settings put global transition_animation_scale 1
  adb shell settings put global window_animation_scale 1
  adb shell settings put global animator_duration_scale 1

  ./tests.sh >> $file
  
  sleep 5
  echo $SECONDS >> $base/time.txt
done

if [ $PID ]
then
  echo "kill stress"
  kill -9  $PID
fi

adb shell settings put global transition_animation_scale 0
adb shell settings put global window_animation_scale 0
adb shell settings put global animator_duration_scale 0

sleep 14
