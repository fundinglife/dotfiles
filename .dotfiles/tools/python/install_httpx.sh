#!/bin/bash

pip install --upgrade pip
pip install httpx

grep -qxF 'httpx' "$HOME/dotfiles/requirements.txt" || echo 'httpx' >> "$HOME/dotfiles/requirements.txt"
