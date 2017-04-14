#!/bin/bash
echo Please wait...
if [ -f /tmp/test.log ]; then
    rm /tmp/test.log
fi

parallel 'timeout 2 curl -o /dev/null {} -w "%{speed_download}" 2> /dev/null; echo " {}"; ' >> /tmp/test.log ::: `cat testlist.txt`

cat /tmp/test.log|grep '[000]'|sort -nr|head -n5|awk '{print $2}'
 