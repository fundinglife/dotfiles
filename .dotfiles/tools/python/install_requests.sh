#!/bin/bash

pip install --upgrade pip
pip install requests

grep -qxF 'requests' "$HOME/dotfiles/requirements.txt" || echo 'requests' >> "$HOME/dotfiles/requirements.txt"
