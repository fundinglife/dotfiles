#!/bin/bash

pip install --upgrade pip
pip install openai

grep -qxF 'openai' "$HOME/dotfiles/requirements.txt" || echo 'openai' >> "$HOME/dotfiles/requirements.txt"
