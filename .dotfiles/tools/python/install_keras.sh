#!/bin/bash

pip install --upgrade pip
pip install keras

grep -qxF 'keras' "$HOME/dotfiles/requirements.txt" || echo 'keras' >> "$HOME/dotfiles/requirements.txt"
