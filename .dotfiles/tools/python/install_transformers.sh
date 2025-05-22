#!/bin/bash

pip install --upgrade pip
pip install transformers

grep -qxF 'transformers' "$HOME/dotfiles/requirements.txt" || echo 'transformers' >> "$HOME/dotfiles/requirements.txt"
