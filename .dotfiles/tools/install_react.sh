#!/bin/bash

if ! command -v npm &> /dev/null; then
    echo "npm not found. Installing Node.js and npm via install_nvm.sh..."
    DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    bash "$DIR/install_nvm.sh"
fi

if ! command -v create-react-app &> /dev/null; then
    echo "create-react-app not found. Installing..."
    npm install -g create-react-app
else
    echo "✅ create-react-app is already installed."
fi
