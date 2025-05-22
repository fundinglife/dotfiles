#!/bin/bash

pip install --upgrade pip
pip install scipy

grep -qxF 'scipy' "$HOME/dotfiles/requirements.txt" || echo 'scipy' >> "$HOME/dotfiles/requirements.txt"
