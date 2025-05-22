#!/bin/bash

pip install --upgrade pip
pip install spacy

grep -qxF 'spacy' "$HOME/dotfiles/requirements.txt" || echo 'spacy' >> "$HOME/dotfiles/requirements.txt"
