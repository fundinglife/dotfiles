#!/bin/bash

pip install --upgrade pip
pip install bitsandbytes

grep -qxF 'bitsandbytes' "$HOME/dotfiles/requirements.txt" || echo 'bitsandbytes' >> "$HOME/dotfiles/requirements.txt"
