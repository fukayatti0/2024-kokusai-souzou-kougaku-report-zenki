#!/bin/bash

touch shellscript.log
truncate shellscript.log --size 0

start_time=$(date +%s%2N)

bash HundredMillionCalc.sh

execute_time=$(( $(date +%s%2N) - $start_time ))

echo "実行時間: $(echo "scale=2; $execute_time / 100" | bc) 秒" > shellscript.log