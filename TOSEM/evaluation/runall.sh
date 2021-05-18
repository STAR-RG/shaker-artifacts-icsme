#!/bin/bash

PID_EMULATOR=$1

### RQ1
NUM_EXECS_RQ1=$2
RUN_STATS_RQ1=$3

echo " ============================================="
echo " ================ RUNNING RQ1 ================"
echo " ============================================="
./rq1.sh $PID_EMULATOR $NUM_EXECS_RQ1 $RUN_STATS_RQ1

### RQ2

NUM_CONFIGS_RQ2=$4
NUM_EXECS_RQ2=$5

echo " ============================================="
echo " ================ RUNNING RQ2 ================"
echo " ============================================="
./rq2.sh $PID_EMULATOR $NUM_CONFIGS_RQ2 $NUM_EXECS_RQ2

### RQ3

NUM_CONFIGS_RQ3=$6
NUM_EXECS_TRAINING_RQ3=$7
THRESHOLD_RQ3=$8
NUM_EXECS_TEST_RQ3=$9

echo " ============================================="
echo " ================ RUNNING RQ3 ================"
echo " ============================================="
./rq3.sh $PID_EMULATOR $NUM_CONFIGS_RQ3 $NUM_EXECS_TRAINING_RQ3 $THRESHOLD_RQ3 $NUM_EXECS_TEST_RQ3

### RQ4

NUM_EXECS_RERUN_RQ4=${10}
NUM_EXECS_SHAKER_RQ4=${11}

echo " ============================================="
echo " ================ RUNNING RQ4 ================"
echo " ============================================="
./rq4.sh $PID_EMULATOR $NUM_EXECS_RERUN_RQ4 $NUM_EXECS_SHAKER_RQ4

### RQ5

NUM_EXECS_SHAKER_RQ5=${12}

echo " ============================================="
echo " ================ RUNNING RQ5 ================"
echo " ============================================="
./rq5.sh $PID_EMULATOR $NUM_EXECS_SHAKER_RQ5