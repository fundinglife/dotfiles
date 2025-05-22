#!/bin/bash

pip install --upgrade pip
pip install asyncpg

grep -qxF 'asyncpg' "$HOME/dotfiles/requirements.txt" || echo 'asyncpg' >> "$HOME/dotfiles/requirements.txt"
