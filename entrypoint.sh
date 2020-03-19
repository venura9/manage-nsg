#!/bin/sh -l

echo "Hello $1"

az group list

time=$(date)
dig +short myip.opendns.com @resolver1.opendns.com
echo ::set-output name=time::$time
