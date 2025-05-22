#!/bin/bash

pip install --upgrade pip
pip install datasets

grep -qxF 'datasets' "$HOME/dotfiles/requirements.txt" || echo 'datasets' >> "$HOME/dotfiles/requirements.txt"
