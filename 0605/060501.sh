#!/bin/bash

#find -type f | wc -l
#find -type d | wc -l


filesize=$(find ~/ -type f | wc -l)
echo "ファイル数$filesize"

directorysize=$(find ~/ -type d | wc -l)
echo "ディレクトリ数$directorysize"
