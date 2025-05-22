#!/bin/bash

pip install --upgrade pip
pip install flask

grep -qxF 'flask' "$HOME/dotfiles/requirements.txt" || echo 'flask' >> "$HOME/dotfiles/requirements.txt"
