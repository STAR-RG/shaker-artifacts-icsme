#!/bin/bash

PID_EMULATOR=$1
NUM_CONFIGS=$2
NUM_EXECS_TRAINING=$3
THRESHOLD=$4
NUM_EXECS_TEST=$5

strategies=( "greedy" "MHS" "random" )

(
    cd rq3
    echo ""
    echo " >>>> Execute training phase (RQ3)"
    python3 setup.py $NUM_CONFIGS $NUM_EXECS $THRESHOLD $PID_EMULATOR
    
    for strategy in "${strategies[@]}"
    do
        echo ""
        echo " >>>> Execute test phase for $strategy (RQ3)"
        python3 exec.py $strategy $NUM_EXECS_TEST $PID_EMULATOR
        echo ""
    done
    
    echo ""
    #TODO run stats
)