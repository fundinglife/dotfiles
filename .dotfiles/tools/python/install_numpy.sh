#!/bin/bash

pip install --upgrade pip
pip install numpy

grep -qxF 'numpy' "$HOME/dotfiles/requirements.txt" || echo 'numpy' >> "$HOME/dotfiles/requirements.txt"
