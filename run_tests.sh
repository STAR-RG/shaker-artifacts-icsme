#!/bin/bash
mkdir logs
./e.sh 2>&1 | tee logs/log.txt
cd test
 ./run.sh 2>&1 | tee -a ../logs/log.txt
 python3 exec.py 2>&1 | tee -a ../logs/log.txt
cd ..

echo "Done!. The log is in /log"
