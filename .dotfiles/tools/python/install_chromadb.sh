#!/bin/bash

pip install --upgrade pip
pip install chromadb

grep -qxF 'chromadb' "$HOME/dotfiles/requirements.txt" || echo 'chromadb' >> "$HOME/dotfiles/requirements.txt"
