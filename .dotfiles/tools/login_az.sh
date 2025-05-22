#!/bin/bash

if ! az account show &>/dev/null; then
    echo "Logging into Azure CLI using service principal..."
    az login --service-principal -u "$AZ_CLIENT_ID" -p "$AZ_CLIENT_SECRET" --tenant "$AZ_TENANT_ID"
else
    echo "✅ Azure CLI is already authenticated"
fi

