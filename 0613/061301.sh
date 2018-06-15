today=$(date '+%s')
sv=$(date -d '2018/9/10' '+%s')
diff=$((sv - today))
leftdays=$(expr $diff / 86400 + 1)
echo "夏休みまで残り$leftdays日"

