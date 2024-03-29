#!bin/bash

file="/var/log/apache2/access.log"

function countingCurlAccess(){
curlFind=$(cat "$file" | grep "curl" | cut -d' ' -f1,12)
}

countingCurlAccess

echo "$curlFind" > curlFile.txt

counted=$(sort curlFile.txt | uniq -c)

echo "$counted"
