#!/bin/bash

pip install --upgrade pip
pip install rich

grep -qxF 'rich' "$HOME/dotfiles/requirements.txt" || echo 'rich' >> "$HOME/dotfiles/requirements.txt"
