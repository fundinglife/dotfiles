#!/bin/bash

pip install --upgrade pip
pip install diffusers

grep -qxF 'diffusers' "$HOME/dotfiles/requirements.txt" || echo 'diffusers' >> "$HOME/dotfiles/requirements.txt"
