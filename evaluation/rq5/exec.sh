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

  if [[ $8 == "wifi" ]]
  then
    echo "Testing WiFiAnalyzer"
    adb shell am instrument -w -r    -e package com.vrem.wifianalyzer -e debug false com.vrem.wifianalyzer.BETA.test/androidx.test.runner.AndroidJUnitRunner >> $file
    echo "Finished WiFiAnalyzer"
  fi
  
  if [[ $8 == "kiss" ]]
  then
    echo "Testing KISS"
    adb shell am instrument -w -r    -e package fr.neamar.kiss.androidTest -e debug false fr.neamar.kiss.debug.test/androidx.test.runner.AndroidJUnitRunner >> $file
    echo "Finished KISS"
  fi
  
  if [[ $8 == "omninotes" ]]
  then
    echo "Testing omninotes"
    adb shell am instrument -w -r    -e package it.feio.android.omninotes -e debug false it.feio.android.omninotes.alpha.test/androidx.test.runner.AndroidJUnitRunner >> $file
    echo "Finished omninotes"
  fi
  
  if [[ $8 == "paintroid" ]]
  then
    echo "Testing paintroid"
    adb shell am instrument -w -r    -e package org.catrobat.paintroid.test -e debug false org.catrobat.paintroid.test/android.support.test.runner.AndroidJUnitRunner >> $file
    echo "Finished paintroid"
  fi

  if [[ $8 == "susi" ]]
  then
    echo "Testing susi"
    adb shell am instrument -w -r    -e package org.fossasia.susi.ai -e debug false ai.susi.test/android.support.test.runner.AndroidJUnitRunner >> $file
    echo "Finished susi"
  fi

  if [[ $8 == "firefoxlite" ]]
  then
    echo "Testing FirefoxLite"
    adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e package org.mozilla -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
    echo "Finished FirefoxLite"
  fi

  if [[ $8 == "orgzly" ]]
  then
    echo "Testing orgzly"
    echo ""
    adb shell am instrument -w -r    -e package com.orgzly.android.espresso -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
    echo "mid-way... orgzly"
    adb shell am instrument -w -r    -e package com.orgzly.android.uiautomator -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
    echo "Finished orgzly"
  fi

  if [[ $8 == "espresso" ]]
  then
    echo "Testing espresso"
    adb shell am instrument -w -r    -e package io.github.marktony.espresso -e debug false io.github.marktony.espresso.test/android.support.test.runner.AndroidJUnitRunner >> $file
    echo "Finished espresso"
  fi

  if [[ $8 == "antennapod" ]]
  then
    echo "Testing AntennaPod"
    adb shell am instrument -w -r  --no-window-animation  -e debug false -e package de.test.antennapod de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
    echo "Finished AntennaPod"
  fi

  if [[ $8 == "anymemo" ]]
  then
    echo "Testing AnyMemo"
    adb shell am instrument -w -r    -e package org.liberty.android.fantastischmemo -e debug false org.liberty.android.fantastischmemo.test/androidx.test.runner.AndroidJUnitRunner >> $file
    echo "Finished AnyMemo"
  fi

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
