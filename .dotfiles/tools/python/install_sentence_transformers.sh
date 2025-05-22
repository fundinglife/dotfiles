#!/bin/bash

pip install --upgrade pip
pip install sentence-transformers

grep -qxF 'sentence-transformers' "$HOME/dotfiles/requirements.txt" || echo 'sentence-transformers' >> "$HOME/dotfiles/requirements.txt"
