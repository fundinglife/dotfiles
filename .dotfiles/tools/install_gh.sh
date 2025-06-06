#!/bin/bash

if ! command -v gh &> /dev/null; then
    echo "GitHub CLI not found. Installing..."
    type -p curl >/dev/null || sudo apt-get install curl -y
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt-get update
    sudo apt-get install gh -y
fi

bash "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/login_gh.sh"