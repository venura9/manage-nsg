# Attempt #1 - starting from scratch > too hard > gave up 

# FROM alpine:3.10

# Enable dig
#RUN apk update && apk add --no-cache bind-tools && rm -rf /var/cache/apk/*

# Some more packages
# RUN apk add --no-cache curl tar openssl sudo bash jq python3

# Enable Azure CLI
# RUN curl -L https://aka.ms/InstallAzureCli | sed -e "s/XXXX/XXXXXX/g" | bash


# Attempt #2 - using micrososft's azure cli container > just worked

# Using latest might cause issues with breaking changes.
# FROM mcr.microsoft.com/azure-cli:latest

# https://hub.docker.com/_/microsoft-azure-cli
# https://mcr.microsoft.com/v2/azure-cli/tags/list
FROM mcr.microsoft.com/azure-cli:2.8.0

# Copies your code file from your action repository to the filesystem path `/` of the container.
COPY entrypoint.sh /entrypoint.sh

# Set the missing exec permission, just in case if you're on on a *nix. 
RUN chmod +x ./entrypoint.sh

# Enable dig to find the runner's public IP
RUN apk update && apk add --no-cache bind-tools && rm -rf /var/cache/apk/*

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

