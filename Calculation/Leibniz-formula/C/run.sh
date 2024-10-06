#!/bin/bash

touch clang.log
truncate clang.log --size 0

start_time=$(date +%s%2N)

gcc -O3 Leibniz.c -o Leibniz -lm
./Leibniz

execute_time=$(( $(date +%s%2N) - $start_time ))

echo "実行時間: $(echo "scale=2; $execute_time / 100" | bc) 秒" > clang.log