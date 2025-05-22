#!/bin/bash

pip install --upgrade pip
pip install beautifulsoup4

grep -qxF 'beautifulsoup4' "$HOME/dotfiles/requirements.txt" || echo 'beautifulsoup4' >> "$HOME/dotfiles/requirements.txt"
