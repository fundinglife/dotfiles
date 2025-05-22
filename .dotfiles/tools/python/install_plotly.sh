#!/bin/bash

pip install --upgrade pip
pip install plotly

grep -qxF 'plotly' "$HOME/dotfiles/requirements.txt" || echo 'plotly' >> "$HOME/dotfiles/requirements.txt"
