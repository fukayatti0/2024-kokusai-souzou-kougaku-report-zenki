#!/bin/bash

touch c++.log
truncate c++.log --size 0

start_time=$(date +%s%2N)

g++ -O3 HundredMillionCalc.cpp -o HundredMillionCalc
./HundredMillionCalc

execute_time=$(( $(date +%s%2N) - $start_time ))

echo "実行時間: $(echo "scale=2; $execute_time / 100" | bc) 秒" > c++.log