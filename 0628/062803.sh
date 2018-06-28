#!/bin/bash
# 5/8から今日までの日数

today=$(date '+%s')
date=$(date -d '2018/5/8' '+%s')
diff=$((today - date))
elapsed_days=$(expr $diff / 86400)
echo "5月8日から$elapsed_days日経ちました。"
