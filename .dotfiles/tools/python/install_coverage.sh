#!/bin/bash

pip install --upgrade pip
pip install coverage

grep -qxF 'coverage' "$HOME/dotfiles/requirements.txt" || echo 'coverage' >> "$HOME/dotfiles/requirements.txt"
