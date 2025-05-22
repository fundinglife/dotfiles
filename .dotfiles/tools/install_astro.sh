#!/bin/bash

# Install Astro (astro.build) CLI globally using npm
if ! command -v npm &> /dev/null; then
    echo "npm not found. Installing Node.js and npm via install_nvm.sh..."
    DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    bash "$DIR/install_nvm.sh"
fi

echo "Installing Astro CLI globally..."
sudo npm install -g astro