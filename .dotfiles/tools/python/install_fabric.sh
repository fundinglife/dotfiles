#!/bin/bash

pip install --upgrade pip
pip install fabric

grep -qxF 'fabric' "$HOME/dotfiles/requirements.txt" || echo 'fabric' >> "$HOME/dotfiles/requirements.txt"
