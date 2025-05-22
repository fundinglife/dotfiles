#!/bin/bash

pip install --upgrade pip
pip install lxml

grep -qxF 'lxml' "$HOME/dotfiles/requirements.txt" || echo 'lxml' >> "$HOME/dotfiles/requirements.txt"
