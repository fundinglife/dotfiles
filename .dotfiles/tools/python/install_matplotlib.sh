#!/bin/bash

pip install --upgrade pip
pip install matplotlib

grep -qxF 'matplotlib' "$HOME/dotfiles/requirements.txt" || echo 'matplotlib' >> "$HOME/dotfiles/requirements.txt"
