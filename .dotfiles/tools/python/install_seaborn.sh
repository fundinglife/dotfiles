#!/bin/bash

pip install --upgrade pip
pip install seaborn

grep -qxF 'seaborn' "$HOME/dotfiles/requirements.txt" || echo 'seaborn' >> "$HOME/dotfiles/requirements.txt"
