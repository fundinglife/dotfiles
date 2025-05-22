#!/bin/bash

pip install --upgrade pip
pip install torch

grep -qxF 'torch' "$HOME/dotfiles/requirements.txt" || echo 'torch' >> "$HOME/dotfiles/requirements.txt"
