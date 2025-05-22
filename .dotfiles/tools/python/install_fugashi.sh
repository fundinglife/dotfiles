#!/bin/bash

pip install --upgrade pip
pip install fugashi

grep -qxF 'fugashi' "$HOME/dotfiles/requirements.txt" || echo 'fugashi' >> "$HOME/dotfiles/requirements.txt"
