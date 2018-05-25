cut -d : -f 1,3 /etc/passwd | tr : '  '| sort -nr -k 2 
