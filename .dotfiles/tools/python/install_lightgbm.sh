#!/bin/bash

pip install --upgrade pip
pip install lightgbm

grep -qxF 'lightgbm' "$HOME/dotfiles/requirements.txt" || echo 'lightgbm' >> "$HOME/dotfiles/requirements.txt"
