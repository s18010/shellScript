#!/bin/bash

cat personal_infomation.csv | awk -F'[,]' '{print $7}' | sort | uniq -c | sort -nr | head -n 5
