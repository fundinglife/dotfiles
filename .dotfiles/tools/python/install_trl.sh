#!/bin/bash

pip install --upgrade pip
pip install trl

grep -qxF 'trl' "$HOME/dotfiles/requirements.txt" || echo 'trl' >> "$HOME/dotfiles/requirements.txt"
