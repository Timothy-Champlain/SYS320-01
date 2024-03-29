#!bin/bash

allLogs=""
file="/var/log/apache2/access.log"

#results=$(cat "$file" | grep "GET /page1.html" | cut -d' ' -f1,7 | tr -d "/")

function getAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f7)
}

function ips(){
ipsAccessed=$(echo "$allLogs" | cut -d' ' -f1)
}

#echo "Before function:"
#echo "$allLogs"

getAllLogs
ips
#echo "$ipsAccessed"
#echo "After function:"
#echo "$allLogs"

#echo "$results"

echo "$allLogs" > logFile.txt

counted=$(sort logFile.txt | uniq -c)

echo "$counted"
