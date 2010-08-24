#!/bin/bash
# a basic crawler in bash
# usage: crawl.sh urlfile.txt 
URLS_FILE=$1
BANDWIDTH=2300
CRAWLERS=100
RATE_LIMIT=$(($BANDWIDTH/$CRAWLERS))


mkdir -p data/pages

WGET_CMD="wget \
  --tries=5 \
  --dns-timeout=5 \
  --connect-timeout=5 \
  --read-timeout=5 \
  --timestamping \
  --limit-rate=${RATE_LIMIT}k  \
  --directory-prefix=data/pages \
  --wait=2 \
  --random-wait \
  --recursive \
  --level=5 \
  --no-parent \
  --no-verbose \
  --reject *.jpg --reject *.gif \
  --reject *.png --reject *.css \
  --reject *.pdf --reject *.bz2 \
  --reject *.gz  --reject *.zip \
  --reject *.mov --reject *.fla \
  --reject *.xml \
  --no-check-certificate"

cat $URLS_FILE | xargs  -P $CRAWLERS -I _URL_ $WGET_CMD _URL_
