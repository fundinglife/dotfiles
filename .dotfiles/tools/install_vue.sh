#!/bin/bash

if ! command -v npm &> /dev/null; then
    echo "npm not found. Installing Node.js and npm via install_nvm.sh..."
    DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    bash "$DIR/install_nvm.sh"
fi

if ! command -v vue &> /dev/null; then
    echo "Vue CLI not found. Installing..."
    npm install -g @vue/cli
else
    echo "✅ Vue CLI is already installed."
fi
