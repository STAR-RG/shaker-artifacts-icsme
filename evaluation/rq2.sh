#!/bin/bash

PID_EMULATOR=$1
NUM_CONFIGS=$2
NUM_EXECS=$3

(
    cd rq2
    python3 exec.py $NUM_CONFIGS $NUM_EXECS $PID_EMULATOR
    #TODO run R from command line? 
    Rscript variance.r
)