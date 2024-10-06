#!/bin/bash

touch java.log
truncate java.log --size 0

start_time=$(date +%s%2N)

javac HundredMillionCalc.java
java -server HundredMillionCalc

execute_time=$(( $(date +%s%2N) - $start_time ))

echo "実行時間: $(echo "scale=2; $execute_time / 100" | bc) 秒" > java.log