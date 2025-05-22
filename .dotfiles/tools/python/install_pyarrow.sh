#!/bin/bash

pip install --upgrade pip
pip install pyarrow

grep -qxF 'pyarrow' "$HOME/dotfiles/requirements.txt" || echo 'pyarrow' >> "$HOME/dotfiles/requirements.txt"
