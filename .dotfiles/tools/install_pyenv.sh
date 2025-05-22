#!/bin/bash

if ! command -v pyenv &> /dev/null; then
    echo "pyenv not found. Installing..."
    curl https://pyenv.run | bash
else
    echo "✅ pyenv is already installed."
fi

# Initialize pyenv for this script
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init -)"
    # Install latest stable Python if not already installed
    latest_python=$(pyenv install --list | grep -E '^  [0-9]+\.[0-9]+\.[0-9]+$' | tail -1 | tr -d ' ')
    if ! pyenv versions --bare | grep -q "^$latest_python$"; then
        echo "Installing latest Python ($latest_python) with pyenv..."
        pyenv install "$latest_python"
        pyenv global "$latest_python"
    else
        echo "✅ Python $latest_python is already installed with pyenv."
    fi
else
    echo "❌ pyenv installation failed or not found in PATH."
fi