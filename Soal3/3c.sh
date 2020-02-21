#!/bin/bash


d=1
k=1
dir=$(pwd)

for ((i=1; i<=28; i++))
do

for((j=1; j<=28; j++))
do

if [ $i -eq $j ]
then
	z=1

elif  cmp -s "pdkt_kusuma_"$i"" "pdkt_kusuma_"$j"" ;
then
	mv "pdkt_kusuma_"$j""  "duplicate_"$d""
	mv "duplicate_"$d"" duplicate
	d=$((d+1))

else
z=0

fi
done

if [ -f "pdkt_kusuma_"$i"" ]; then

mv "pdkt_kusuma_"$i"" "kenangan_"$k
mv "kenangan_"$k"" kenangan
k=$((k+1))

fi


done


mv "wget.log" "wget.log.bak"
mv "location.log" "location.log.bak"

