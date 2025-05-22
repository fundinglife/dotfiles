#!/bin/bash

pip install --upgrade pip
pip install altair

grep -qxF 'altair' "$HOME/dotfiles/requirements.txt" || echo 'altair' >> "$HOME/dotfiles/requirements.txt"
