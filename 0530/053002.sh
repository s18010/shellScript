cd ~/sample
cat file{1..3}  | sort -r | uniq | sed -n '$p'
