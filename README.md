# Manage NSG for Deployments

![run_test](https://github.com/venura9/manage-nsg/workflows/run_test/badge.svg)

This GitHub action allows a hosted(public) runner image to access resources secured by an Azure Network Security Group (NSG) by creating an allow rule picking the current IP address of the hosted runner, also the same task can be used to remove existing NSG rules allowing the cleanup of the created rules.

E.g. Web Deploy to a WebApp inside an Azure Application Service Environment (ASE) 

## Usage:
```yaml

  - name: Add the rule for the current agent IP
    uses: venura9/manage-nsg@master

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
