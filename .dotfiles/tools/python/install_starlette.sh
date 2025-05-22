#!/bin/bash

pip install --upgrade pip
pip install starlette

grep -qxF 'starlette' "$HOME/dotfiles/requirements.txt" || echo 'starlette' >> "$HOME/dotfiles/requirements.txt"
