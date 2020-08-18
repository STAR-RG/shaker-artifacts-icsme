#!/bin/bash

PID_EMULATOR=$1
NUM_EXECS_SHAKER=$2

# apps=( "anymemo" "antennapod" "espresso" "orgzly" "firefoxlite" "susi" "paintroid" "omninotes" "kiss" "wifi" )
apps=( "wifi" )

(
    cd rq5
    #Execute Shaker with each app
    for app in "${apps[@]}"
    do
        echo ""
        echo " >>>> Executing SHAKER on $app $NUM_EXECS_SHAKER times"
        python3 exec.py $NUM_EXECS_SHAKER $app $PID_EMULATOR
        mv results.txt $app.txt
    done

)