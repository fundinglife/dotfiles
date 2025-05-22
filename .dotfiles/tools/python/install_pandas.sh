#!/bin/bash

pip install --upgrade pip
pip install pandas

grep -qxF 'pandas' "$HOME/dotfiles/requirements.txt" || echo 'pandas' >> "$HOME/dotfiles/requirements.txt"
