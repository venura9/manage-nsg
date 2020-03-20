#!/bin/sh -l

_azure_credentails=$1
_rule_priority_start=$2
_rule_priority_end=$(($2+$3))
_rule_port=$4
_rule_id_for_removal=$5
_rule_nsg_resource_group=$6
_rule_nsg=$7
_rule_public_ip=$(dig +short myip.opendns.com @resolver1.opendns.com)

_client_id=$(echo $_azure_credentails | jq -r '.clientId')
_client_secret=$(echo $_azure_credentails | jq -r '.clientSecret')
_tenant_id=$(echo $_azure_credentails | jq -r '.tenantId')
_subscription_id=$(echo $_azure_credentails | jq -r '.subscriptionId')

# Login to azure using service principal
az login --service-principal -u $_client_id -p $_client_secret --tenant $_tenant_id

# Select the subscription
az account set --subscription $_subscription_id

# if [ -z "$_rule_id_for_removal" ]
# then
#     echo _rule_port: $_rule_port
#     echo _rule_priority_start: $_rule_priority_start
#     echo _rule_priority_end: $_rule_priority_end

#     _rule_priority=$(shuf -i $_rule_priority_start-$_rule_priority_end -n 1)
#     _rule_name=manage-nsg-github-actions-$_rule_priority

#     echo "Adding rule.... $_rule_name"
#     az network nsg rule create -g $_rule_nsg_resource_group --nsg-name $_rule_nsg -n $_rule_name --priority $_rule_priority --source-address-prefixes $_rule_public_ip --source-port-ranges '*' --destination-address-prefixes '*' --destination-port-ranges '*' --access Allow --protocol '*' --description 'Allow from IP address of github actions hosted runner temporarily'
#     echo "::set-output rule_name=$_rule_name"
# else
#     echo "Removing rule $_rule_id_for_removal"
#     #az network nsg rule delete -g $_rule_nsg_resource_group --nsg-name $_rule_nsg -n $_rule_id_for_removal
#     echo "::set-output rule_name=$_rule_id_for_removal"
# fi


if [ $_rule_id_for_removal ]
then
    echo "Removing rule $_rule_id_for_removal"
    #az network nsg rule delete -g $_rule_nsg_resource_group --nsg-name $_rule_nsg -n $_rule_id_for_removal
    echo "::set-output name=rule_name::$_rule_id_for_removal"
else
    echo _rule_port: $_rule_port
    echo _rule_priority_start: $_rule_priority_start
    echo _rule_priority_end: $_rule_priority_end

    _rule_priority=$(shuf -i $_rule_priority_start-$_rule_priority_end -n 1)
    _rule_name=manage-nsg-github-actions-$_rule_priority

    echo "Adding rule.... $_rule_name"
    az network nsg rule create -g $_rule_nsg_resource_group --nsg-name $_rule_nsg -n $_rule_name --priority $_rule_priority --source-address-prefixes $_rule_public_ip --source-port-ranges '*' --destination-address-prefixes '*' --destination-port-ranges '*' --access Allow --protocol '*' --description 'Allow from IP address of github actions hosted runner temporarily'
    echo "::set-output name=rule_name::$_rule_name"
fi

# time=$(date)
# echo ::set-output name=time::$time
