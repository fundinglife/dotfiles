#!/bin/bash

pip install --upgrade pip
pip install dash

grep -qxF 'dash' "$HOME/dotfiles/requirements.txt" || echo 'dash' >> "$HOME/dotfiles/requirements.txt"
