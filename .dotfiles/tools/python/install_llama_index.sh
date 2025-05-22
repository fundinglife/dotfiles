#!/bin/bash

pip install --upgrade pip
pip install llama-index

grep -qxF 'llama-index' "$HOME/dotfiles/requirements.txt" || echo 'llama-index' >> "$HOME/dotfiles/requirements.txt"
