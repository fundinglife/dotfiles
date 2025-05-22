#!/bin/bash

pip install --upgrade pip
pip install jupyter

grep -qxF 'jupyter' "$HOME/dotfiles/requirements.txt" || echo 'jupyter' >> "$HOME/dotfiles/requirements.txt"
