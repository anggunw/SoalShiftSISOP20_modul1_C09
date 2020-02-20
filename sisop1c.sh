#!/usr/bin/bash
awk 'BEGIN{FS="\t"}
$11=="Texas"||$11=="Illinois"{arr[$17]+=$21}
END{PROCINFO["sorted_in"]="@val_num_asc";
count=0;
for(i in arr){if(count==10)break;print i,arr[i];count++}};' Sample-Superstore.tsv

