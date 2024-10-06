#!/bin/bash

touch swift.log
truncate swift.log --size 0

start_time=$(date +%s%2N)

swiftc Trigonometricfunctions.swift -O
./Trigonometricfunctions

execute_time=$(( $(date +%s%2N) - $start_time ))

echo "実行時間: $(echo "scale=2; $execute_time / 100" | bc) 秒" > swift.log