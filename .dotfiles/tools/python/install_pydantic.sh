#!/bin/bash

pip install --upgrade pip
pip install pydantic

grep -qxF 'pydantic' "$HOME/dotfiles/requirements.txt" || echo 'pydantic' >> "$HOME/dotfiles/requirements.txt"
