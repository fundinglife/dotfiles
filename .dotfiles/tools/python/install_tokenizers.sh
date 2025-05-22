#!/bin/bash

pip install --upgrade pip
pip install tokenizers

grep -qxF 'tokenizers' "$HOME/dotfiles/requirements.txt" || echo 'tokenizers' >> "$HOME/dotfiles/requirements.txt"
