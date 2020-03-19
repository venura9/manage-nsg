#!/bin/sh -l

echo "Hello $1"
time=$(date)
dig +short myip.opendns.com @resolver1.opendns.com
echo ::set-output name=time::$time
