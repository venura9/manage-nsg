#!/bin/sh -l

_client_id=$(echo $6 | jq -r '.clientId')
_client_secret=$(echo $6 | jq -r '.clientSecret')
_tenant_id=$(echo $6 | jq -r '.tenantId')
_subscription_id=$(echo $6 | jq -r '.subscriptionId')

# Login to azure using service principal
az login --service-principal -u $_client_id -p $_client_secret --tenant $_tenant_id

# Select the subscription
az account set --subscription $_subscription_id

# Sample list of resources
az group list

time=$(date)
dig +short myip.opendns.com @resolver1.opendns.com
echo ::set-output name=time::$time
