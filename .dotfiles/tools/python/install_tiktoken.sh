#!/bin/bash

pip install --upgrade pip
pip install tiktoken

grep -qxF 'tiktoken' "$HOME/dotfiles/requirements.txt" || echo 'tiktoken' >> "$HOME/dotfiles/requirements.txt"
