#!/bin/bash

pip install --upgrade pip
pip install pytest

grep -qxF 'pytest' "$HOME/dotfiles/requirements.txt" || echo 'pytest' >> "$HOME/dotfiles/requirements.txt"
