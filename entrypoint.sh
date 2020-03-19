#!/bin/sh -l

_client_id=$(echo $5 | jq -r '.clientId')
_client_secret=$(echo $5 | jq -r '.clientSecret')
_tenant_id=$(echo $5 | jq -r '.tenantId')
_subscription_id=$(echo $5 | jq -r '.subscriptionId')
_public_ip=$(dig +short myip.opendns.com @resolver1.opendns.com)

_rule_priority_start=$1
_rule_priority_end=$(($1+$2))
_rule_port=$3
_rule_id_for_removal=$4

# Login to azure using service principal
az login --service-principal -u $_client_id -p $_client_secret --tenant $_tenant_id

# Select the subscription
az account set --subscription $_subscription_id

echo _rule_id_for_removal: $_rule_id_for_removal
echo _rule_port: $_rule_port
echo _rule_priority_start: $_rule_priority_start
echo _rule_priority_end: $_rule_priority_end
echo blah: $blah

if [ !$_rule_id_for_removal ]
then
  echo "Adding rule"
else
  echo "Removing rule $_rule_id_for_removal"
fi

#time=$(date)
#echo ::set-output name=time::$time
