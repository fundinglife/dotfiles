#!/bin/bash

pip install --upgrade pip
pip install sqlalchemy

grep -qxF 'sqlalchemy' "$HOME/dotfiles/requirements.txt" || echo 'sqlalchemy' >> "$HOME/dotfiles/requirements.txt"
