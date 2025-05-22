#!/bin/bash

pip install --upgrade pip
pip install Pillow

grep -qxF 'Pillow' "$HOME/dotfiles/requirements.txt" || echo 'Pillow' >> "$HOME/dotfiles/requirements.txt"
