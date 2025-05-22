#!/bin/bash

pip install --upgrade pip
pip install openpyxl

grep -qxF 'openpyxl' "$HOME/dotfiles/requirements.txt" || echo 'openpyxl' >> "$HOME/dotfiles/requirements.txt"
