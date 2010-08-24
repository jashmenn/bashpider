#!/bin/bash
# a basic crawler in bash
# usage: crawl.sh urlfile.txt 
URLS_FILE=$1
BANDWIDTH=2300
CRAWLERS=3
RATE_LIMIT=$BANDWIDTH/$CRAWLERS

mkdir -p data/pages

WGET_CMD=wget \
  --limit-rate= \
  --tries=5 \
  --dns-timeout=5 \
  --connect-timeout=5 \
  --read-timeout=5 \
  --timestamping \
  --limit-rate=$RATE_LIMIT  \
  --directory-prefix=data/pages
  --wait=2 \
  --random-wait \
  --html-extension \
  --mirror \
  --recursive \
  --level=5 \
  --convert-links \
  --no-parent \
  --no-verbose \
  --no-check-certificate 

xargs --max-procs $CRAWLERS -I _URL_ $WGET_CMD _URL_ < $URLS_FILE
