#!/bin/bash
mkdir logs
./e.sh > logs/log.txt
cd test
 ./run.sh >> ../logs/log.txt
 python3 exec.py  >> ../logs/log.txt
cd ..

echo "Done!. The log is in /log"
