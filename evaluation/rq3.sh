#!/bin/bash

PID_EMULATOR=$1
NUM_CONFIGS=$2
NUM_EXECS_TRAINING=$3
THRESHOLD=$4
NUM_EXECS_TEST=$5

strategies=( "greedy" "MHS" "random" )

(
    cd rq3
    python3 setup.py $NUM_CONFIGS $NUM_EXECS $THRESHOLD $PID_EMULATOR
    
    for strategy in "${strategies[@]}"
    do
        python3 exec.py $strategy $NUM_EXECS_TEST $PID_EMULATOR
    done
    
    #TODO run stats
)