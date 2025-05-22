#!/bin/bash

pip install --upgrade pip
pip install peft

grep -qxF 'peft' "$HOME/dotfiles/requirements.txt" || echo 'peft' >> "$HOME/dotfiles/requirements.txt"
