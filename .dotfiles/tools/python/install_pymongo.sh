#!/bin/bash

pip install --upgrade pip
pip install pymongo

grep -qxF 'pymongo' "$HOME/dotfiles/requirements.txt" || echo 'pymongo' >> "$HOME/dotfiles/requirements.txt"
