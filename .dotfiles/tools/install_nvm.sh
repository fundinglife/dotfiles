#!/bin/bash

if ! command -v nvm &> /dev/null; then
    echo "nvm not found. Installing..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    echo "Installing latest Node.js and npm using nvm..."
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install node
else
    echo "✅ nvm is already installed."
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    if ! command -v node &> /dev/null; then
        echo "Node.js not found. Installing latest Node.js and npm using nvm..."
        nvm install node
    else
        echo "✅ Node.js and npm are already installed."
    fi
fi
