#!/bin/bash
# a basic crawler in bash
# usage: crawl.sh urlfile.txt <numprocs>
URLS_FILE=$1
BANDWIDTH=2300
CRAWLERS=$2

mkdir -p data/pages

# add this in below if you want to limit the rate of an individual crawler,
# though I would suggest you oversubscribe otherwise some crawlers will be
# starved while waiting for slow neighbors.
#
# RATE_LIMIT=$(($BANDWIDTH/$CRAWLERS))
# --limit-rate=${RATE_LIMIT}k  \

WGET_CMD="wget \
  --tries=5 \
  --dns-timeout=30 \
  --connect-timeout=5 \
  --read-timeout=5 \
  --timestamping \
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
