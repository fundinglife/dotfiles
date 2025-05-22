#!/bin/bash

if ! command -v az &> /dev/null; then
    echo "Azure CLI not found. Installing..."
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
fi

bash "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/login_az.sh"