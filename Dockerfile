# Container image that runs your code
FROM alpine:3.10

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Set the missing exec permission
RUN chmod +x ./entrypoint.sh

# Enable dig
RUN apk update && apk add bind-tools && rm -rf /var/cache/apk/*

# Enable Azure CLI
RUN curl -L https://aka.ms/InstallAzureCli | bash

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
