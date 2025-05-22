#!/bin/bash

pip install --upgrade pip
pip install urllib3

grep -qxF 'urllib3' "$HOME/dotfiles/requirements.txt" || echo 'urllib3' >> "$HOME/dotfiles/requirements.txt"
