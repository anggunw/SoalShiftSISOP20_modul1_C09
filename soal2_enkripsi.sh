#!/bin/bash

echo "$1"
hour=$(date +%H)

txt="$1"
ori="$txt"
txt=${txt/txt}
encrypt='[a-z]'

echo "Jam di enkripsi : $hour"

case "$hour" in
"0")
encrypt='[a-z]'
;;
"1")
encrypt='[b-za]'
;;
"2")
encrypt='[c-za-b]'
;;
"3")
encrypt='[d-za-c]'
;;
"4")
encrypt='[e-za-d]'
;;
"5")
encrypt='[f-za-e]'
;;
"6")
encrypt='[g-za-f]'
;;
"7")
encrypt='[h-za-g]'
;;
"8")
encrypt='[i-za-h]'
;;
"9")
encrypt='[j-za-i]'
;;
"10")
encrypt='[k-za-j]'
;;
"11")
encrypt='[l-za-k]'
;;
"12")
encrypt='[m-za-l]'
;;
"13")
encrypt='[n-za-m]'
;;
"14")
encrypt='[o-za-n]'
;;
"15")
encrypt='[p-za-o]'
;;
"16")
encrypt='[q-za-p]'
;;
"17")
encrypt='[r-za-q]'
;;
"18")
encrypt='[s-za-r]'
;;
"19")
encrypt='[t-za-s]'
;;
"20")
encrypt='[u-za-t]'
;;
"21")
encrypt='[v-za-u]'
;;
"22")
encrypt='[w-za-v]'
;;
"23")
encrypt='[x-za-w]'
;;

esac

ren=$( echo "$txt" | tr '[a-z]' "$encrypt" )
ren="${ren}txt"

mv "$1" "$ren"

