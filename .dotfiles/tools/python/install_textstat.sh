#!/bin/bash

pip install --upgrade pip
pip install textstat

grep -qxF 'textstat' "$HOME/dotfiles/requirements.txt" || echo 'textstat' >> "$HOME/dotfiles/requirements.txt"
