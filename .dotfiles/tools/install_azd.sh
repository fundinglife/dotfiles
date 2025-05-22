#!/bin/bash

if ! command -v azd &> /dev/null; then
    echo "Azure Dev CLI not found. Installing..."
    curl -fsSL https://aka.ms/install-azd.sh | bash
fi

bash "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/login_azd.sh"