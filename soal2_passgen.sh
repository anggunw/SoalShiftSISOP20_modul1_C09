#!/bin/bash

arg="$1"

arg=${arg//[0-9]/}
#echo "$arg"
cat /dev/urandom| tr -dc 'a-zA-Z0-9'|fold -w 28| head -n 1  >> "$arg".txt
