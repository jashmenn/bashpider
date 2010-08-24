#!/bin/bash
# take n random lines from a file in bash. It takes a while, I bet there is a better way
# usage: random-lines.sh file numwanted

FILE=$1
NUM_WANTED=$2
NUM=$(wc -l < ${FILE})
for i in $(seq 1 $NUM_WANTED 1)
  do
    let LINE=$((${RANDOM} % ${NUM}))
    sed -n ${LINE}p ${FILE}
  done

# ls -lh data/dmoz/urls.txt | cut -d " " -f 6
