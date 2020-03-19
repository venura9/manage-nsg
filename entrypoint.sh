#!/bin/sh -l

echo "Hello $1"

echo $6 | jq '.[]'


az group list

time=$(date)
dig +short myip.opendns.com @resolver1.opendns.com
echo ::set-output name=time::$time
