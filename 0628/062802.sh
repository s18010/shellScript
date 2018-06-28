#!/bin/bash

if [ $# -eq 0 ] ; then
    echo "Usage: 062802.sh PATH"
    exit 1
else
    find $1 -type f | xargs du -b | sort -nr | head -n 5
    exit 0
fi
