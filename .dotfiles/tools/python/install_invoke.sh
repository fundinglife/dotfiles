#!/bin/bash

pip install --upgrade pip
pip install invoke

grep -qxF 'invoke' "$HOME/dotfiles/requirements.txt" || echo 'invoke' >> "$HOME/dotfiles/requirements.txt"
