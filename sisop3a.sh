#!/bin/bash

i=1
while [[ $i -lt 29 ]]
do
 wget -O pdkt_kusuma_$i loremflickr.com/320/240/cat -a wget.log
 #echo $i
 i=$((i + 1))
done
grep 'Location' wget.log > location.log
