# Manage NSG for Deployments

![run_test_master](https://github.com/venura9/manage-nsg/workflows/run_test_master/badge.svg) ![run_test_develop](https://github.com/venura9/manage-nsg/workflows/run_test_develop/badge.svg)

This GitHub action allows a hosted(public) runner image to access resources secured by an Azure Network Security Group (NSG) by creating an allow rule picking the current IP address of the hosted runner, also the same task can be used to remove existing NSG rules allowing the cleanup of the created rules.

E.g. Web Deploy to a WebApp inside an Azure Application Service Environment (ASE) 

## Sample Usage:
```yaml

name: run_test_master

on:
  push:
    branches:
      - master

jobs:
  test:
    runs-on: ubuntu-latest
    name: Run GitHub Action Tests
    steps:
    
      - name: dig +short myip.opendns.com @resolver1.opendns.com
        run: dig +short myip.opendns.com @resolver1.opendns.com

      - name: Add NSG Rule
        uses: venura9/manage-nsg@master
        id: rule
        with:
          azure-credentials: ${{ secrets.AZURE_CREDENTIALS }}
          rule-nsg-resource-group-name: ManageNsg
          rule-nsg-name: ManageNsg

      - name: Print Created NSG Rule Name
        run: echo "Rule Name ${{ steps.rule.outputs.rule_name }}"

      - name: Remove NSG Rule
        uses: venura9/manage-nsg@master
        with:
          azure-credentials: ${{ secrets.AZURE_CREDENTIALS }}
          rule-id-for-removal: ${{ steps.rule.outputs.rule_name }}
          rule-nsg-resource-group-name: ManageNsg
          rule-nsg-name: ManageNsg

```

## Configure Azure credentials:

To fetch the credentials required to authenticate with Azure, run the following command to generate an Azure Service Principal (SPN) with Contributor permissions:

```sh
az ad sp create-for-rbac --name "myApp" --role contributor \
                         --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group} \
                         --sdk-auth
                            
# Replace {subscription-id}, {resource-group} with yout subscription, resource group details

# The command should output a JSON object similar to this:

{
  "clientId": "<GUID>",
  "clientSecret": "<GUID>",
  "subscriptionId": "<GUID>",
  "tenantId": "<GUID>",
  (...)
}

# Note: You can always create the json string manually and add as a secret 
```
Add the json output as [a secret](https://aka.ms/create-secrets-for-GitHub-workflows) (let's say with the name `AZURE_CREDENTIALS`) in the GitHub repository. 
