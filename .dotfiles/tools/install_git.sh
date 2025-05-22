#!/bin/bash

if ! command -v git &> /dev/null; then
    echo "Git not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y git
fi

bash "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/login_git.sh"