#!/bin/bash

for num in $(seq 1 100)
do
if [ $((num%15)) -eq 0 ]; then
    echo -n "FIZZBUZZ,"
elif [ $((num%5)) -eq 0 ]; then
    echo -n "BUZZ,"
elif [ $((num%3)) -eq 0 ]; then
    echo -n "FIZZ,"
else
    echo -n ${num},
fi
done
