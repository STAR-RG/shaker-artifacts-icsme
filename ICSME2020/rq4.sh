#!/bin/bash

PID_EMULATOR=$1
NUM_EXECS_RERUN=$2
NUM_EXECS_SHAKER=$3

(
    cd rq4
    
    #Execute ReRun
    echo ""
    echo " >>>> Executing ReRun $NUM_EXECS_RERUN times"
    ./ReRun.sh $NUM_EXECS_RERUN
    
    #Collect and analyze ReRun data
    echo ""
    echo " >>>> Collecting and analyzing ReRun data"
    python3 exec.py ReRun
    
    #Execute Shaker
    echo ""
    echo " >>>> Executing SHAKER $NUM_EXECS_SHAKER times"
    python3 exec.py $NUM_EXECS_SHAKER $PID_EMULATOR    
    
    #Producing the Area Under the Curve image with R
    #TODO fix running R
    # Rscript auc.r
)