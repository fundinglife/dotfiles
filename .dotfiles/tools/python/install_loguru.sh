#!/bin/bash

pip install --upgrade pip
pip install loguru

grep -qxF 'loguru' "$HOME/dotfiles/requirements.txt" || echo 'loguru' >> "$HOME/dotfiles/requirements.txt"
