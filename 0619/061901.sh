#!/bin/bash

# cat age | awk '{print int($1/10)}' | sort -n | uniq -c | sed 's/0/0~9/'
# cat age | awk '{print int($1/10)}' | sort -n | uniq -c | awk '{print $2,$1}' | sed 's/^\(*\)/\10~\19/'
# cat age | awk '{print int($1/10)}' | sort -n | uniq -c | awk '{print $2,$1}' | sed 's/^\([1-9]\)/\10~\19/'
cat age | awk '{print int($1/10)}' | sort -n | uniq -c | awk '{print $2,$1}' | sed 's/^\(.*\) /\10~\19 /' | sed '1s/00/0 /'

