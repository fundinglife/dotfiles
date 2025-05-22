#!/bin/bash

pip install --upgrade pip
pip install nltk

grep -qxF 'nltk' "$HOME/dotfiles/requirements.txt" || echo 'nltk' >> "$HOME/dotfiles/requirements.txt"
