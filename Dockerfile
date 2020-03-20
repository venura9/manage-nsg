# Container image that runs your code
# FROM alpine:3.10
# FROM mcr.microsoft.com/azure-cli:latest
FROM mcr.microsoft.com/azure-cli:2.2

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Set the missing exec permission
RUN chmod +x ./entrypoint.sh

# Enable dig
RUN apk update && apk add --no-cache bind-tools && rm -rf /var/cache/apk/*

# Some more packages
# RUN apk add --no-cache curl tar openssl sudo bash jq python3

# Enable Azure CLI
# RUN curl -L https://aka.ms/InstallAzureCli | sed -e "s/XXXX/XXXXXX/g" | bash

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
