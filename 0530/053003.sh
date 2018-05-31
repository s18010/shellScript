cd ~/sample
sed 's/\(.*\)/"\1"/' file{1..3} | sort | uniq
