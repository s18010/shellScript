#!/bin/bash

year=$1
mod4=$(($year%4))
mod100=$(($year%100))
mod400=$(($year%400))
[ $mod400 -eq 0 ] || [ $mod100 -ne 0 ] && [ $mod4 -eq 0 ]
leap_year=$?
if [ $leap_year -eq 0 ]; then
    echo "$1年はうるう年です。"
else
    echo "$1年はうるう年ではありません。"
fi
