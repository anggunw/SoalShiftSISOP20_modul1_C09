#!/usr/bin/bash
awk 'BEGIN{FS="\t"}
FNR>1{arr[$13]+=$21;reg=$13;min=arr[$13]}
END{for(i in arr){if(arr[i]<min){min=arr[i];reg=i}};print reg,min}' Sample-Superstore.tsv
