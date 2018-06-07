#!/bin/bash

for file in $(find ~ -type f)
do
   # echo $file
   size=$(sudo ls -l $file | awk '{print $5}')
# sizeが0か確認し、0なら$fileを表示
   if [ "$size" -eq "0" ]; then
       echo "$file", "$size"
   fi
done

IFS=$IFS
