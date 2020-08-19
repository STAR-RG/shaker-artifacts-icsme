#!/bin/bash

PID_EMULATOR=$1
NUM_CONFIGS=$2
NUM_EXECS=$3

(
    cd rq2
    echo ""
    echo " >>>> Executing Noise Configurations to test variance of results"
    python3 exec.py $NUM_CONFIGS $NUM_EXECS $PID_EMULATOR
    
    #TODO fix running R
    Rscript variance.r
)