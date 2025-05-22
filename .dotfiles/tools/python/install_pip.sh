#!/bin/bash

python3 -m ensurepip --upgrade
pip install --upgrade pip

grep -qxF 'pip' "$HOME/dotfiles/requirements.txt" || echo 'pip' >> "$HOME/dotfiles/requirements.txt"
