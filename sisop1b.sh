#!/usr/bin/bash
awk 'BEGIN{FS="\t"}
$13=="Central"{arr[$11]+=$21}
END{PROCINFO["sorted_in"]="@val_num_asc";
count=0;
for(i in arr){if(count==2)break;print i,arr[i];count++}};' Sample-Superstore.tsv
