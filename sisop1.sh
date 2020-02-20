#!/usr/bin/bash
awk -v region="$reg" 'BEGIN{FS="\t"}
FNR>1{arr[$13]+=$21;reg=$13;min=arr[$13]}
END{for(i in arr){if(arr[i]<min){min=arr[i];reg=i}};print reg > "jawaban1.var";print reg,min}' Sample-Superstore.tsv

region=$(cat jawaban1.var)

awk -v reg="$region" 'BEGIN{FS="\t"}
{if($13 == reg){arr[$11]+=$21}}
END{PROCINFO["sorted_in"]="@val_num_asc";
count=0;
for(i in arr){if(count==2)break;print i > "jawaban2.var";print i,arr[i];count++}}' Sample-Superstore.tsv

states=$(cat jawaban2.var)
state1=$(echo $states | cut -f1 -d' ')
state2=$(echo $states | cut -f2 -d' ')

awk -v st1="$state1" -v st2="$state2" 'BEGIN{FS="\t"}
$11 == st1||$11 == st2{arr[$17]+=$21}
END{PROCINFO["sorted_in"]="@val_num_asc";
count=0;
for(i in arr){if(count==10)break;print i,arr[i];count++}};' Sample-Superstore.tsv
