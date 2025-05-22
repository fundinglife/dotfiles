#!/bin/bash

pip install --upgrade pip
pip install hypothesis

grep -qxF 'hypothesis' "$HOME/dotfiles/requirements.txt" || echo 'hypothesis' >> "$HOME/dotfiles/requirements.txt"
