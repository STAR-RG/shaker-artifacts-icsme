#!/bin/bash

PID_EMULATOR=$1
NUM_EXECS=$2
RUN_STATS=$3

(
    cd rq1
    python3 exec.py normal $NUM_EXECS $PID_EMULATOR
    python3 exec.py shaker $NUM_EXECS $PID_EMULATOR
    if [ $RUN_STATS = "true" ]; then
        python3 rq1.py
    fi
)