#!/bin/bash
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu

touch assembly.log
truncate assembly.log --size 0

start_time=$(date +%s%2N)

nasm -f elf64 -g -F drawf Trigonometricfunctions.asm -o Trigonometricfunctions.o
gcc -no-pie Trigonometricfunctions.o -o Trigonometricfunctions -lm
./Trigonometricfunctions

execute_time=$(( $(date +%s%2N) - $start_time ))

echo "実行時間: $(echo "scale=2; $execute_time / 100" | bc) 秒" > assembly.log