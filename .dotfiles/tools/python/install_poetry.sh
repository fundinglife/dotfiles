#!/bin/bash

pip install --upgrade pip
pip install poetry

grep -qxF 'poetry' "$HOME/dotfiles/requirements.txt" || echo 'poetry' >> "$HOME/dotfiles/requirements.txt"
