#!/bin/bash

pip install --upgrade pip
pip install jinja2

grep -qxF 'jinja2' "$HOME/dotfiles/requirements.txt" || echo 'jinja2' >> "$HOME/dotfiles/requirements.txt"
