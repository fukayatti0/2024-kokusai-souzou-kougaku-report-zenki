#!/bin/bash

touch python3.log
truncate python3.log --size 0

start_time=$(date +%s%2N)

python3.12 Leibniz.py

execute_time=$(( $(date +%s%2N) - $start_time ))

echo "実行時間: $(echo "scale=2; $execute_time / 100" | bc) 秒" > python3.log