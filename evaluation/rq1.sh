#!/bin/bash

PID_EMULATOR=$1
NUM_EXECS=$2
RUN_STATS=$3

(
    cd rq1
    echo ""
    echo " >>>> Running Standard Execution environment"
    python3 exec.py normal $NUM_EXECS $PID_EMULATOR
    echo ""
    echo " >>>> Running Noisy Execution environment"
    python3 exec.py shaker $NUM_EXECS $PID_EMULATOR
    if [ $RUN_STATS = "true" ]; then
        echo ""
        echo " >>>> Calculating stats for RQ1"
        python3 rq1.py
    fi
    echo ""    
)