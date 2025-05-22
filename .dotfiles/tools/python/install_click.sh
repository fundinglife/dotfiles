#!/bin/bash

pip install --upgrade pip
pip install click

grep -qxF 'click' "$HOME/dotfiles/requirements.txt" || echo 'click' >> "$HOME/dotfiles/requirements.txt"
