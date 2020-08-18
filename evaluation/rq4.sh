#!/bin/bash

PID_EMULATOR=$1
NUM_EXECS_RERUN=$2
NUM_EXECS_SHAKER=$3

(
    cd rq4
    #Execute ReRun
    ./ReRun.sh $NUM_EXECS_RERUN
    #Collect and analyze ReRun data
    python3 exec.py ReRun
    #Execute Shaker
    python3 exec.py $NUM_EXECS_SHAKER $PID_EMULATOR    
    #Producing the Area Under the Curve image with R
    Rscript auc.r
)