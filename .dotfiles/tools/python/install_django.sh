#!/bin/bash

pip install --upgrade pip
pip install django

grep -qxF 'django' "$HOME/dotfiles/requirements.txt" || echo 'django' >> "$HOME/dotfiles/requirements.txt"
