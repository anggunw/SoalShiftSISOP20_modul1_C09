#!/bin/bash

awk 'BEGIN{FS="\n"}
{if($0 != "Location: https://loremflickr.com/320/240/cat [following]")
 {duplicate[$0]++;count++}}
{if(duplicate[$0] > 1)
 {print "ketemu index ke-", count;idx[i]=count;i++}
 {old="./pdkt_kusuma_"+$count;print old}
{mv "./pdkt_kusuma_$count" "./duplikat_$count"}
}' location.log
