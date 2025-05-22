#!/bin/bash

pip install --upgrade pip
pip install tensorflow

grep -qxF 'tensorflow' "$HOME/dotfiles/requirements.txt" || echo 'tensorflow' >> "$HOME/dotfiles/requirements.txt"
