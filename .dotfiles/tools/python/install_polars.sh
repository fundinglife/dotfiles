#!/bin/bash

pip install --upgrade pip
pip install polars

grep -qxF 'polars' "$HOME/dotfiles/requirements.txt" || echo 'polars' >> "$HOME/dotfiles/requirements.txt"
