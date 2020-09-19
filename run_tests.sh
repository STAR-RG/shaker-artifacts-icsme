#!/bin/bash
mkdir logs
./e.sh
cd test
 ./run.sh
 python3 exec.py 2>&1 | tee -a ../logs/log.txt
cd ..

echo "Done!. The log is in /log"
