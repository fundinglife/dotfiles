#!/bin/bash

pip install --upgrade pip
pip install accelerate

grep -qxF 'accelerate' "$HOME/dotfiles/requirements.txt" || echo 'accelerate' >> "$HOME/dotfiles/requirements.txt"
